import subprocess as sp
import random
import os
import sys
import cgi

def safe_run(command, timeout=3, **kwargs):
  # Workaround for check_output which can kill child processes that are holding things up
  # i.e., the Makefile runs ghdl_mcode, and it's not quitting.
  # https://stackoverflow.com/questions/36952245/subprocess-timeout-failure
  with sp.Popen(command, stdout=sp.PIPE, preexec_fn=os.setsid, **kwargs) as process:
    try:
      output = process.communicate(timeout=timeout)[0]
      # Just leave the result as bytes, since that's what we gotta send out
      return(output)
    except sp.CalledProcessError as e:
        if e.returncode == -sp.signal.SIGSEGV:
            return(b"Program segfaulted")
    except sp.TimeoutExpired:
      os.killpg(process.pid, sp.signal.SIGINT) # Kill the whole process group, pronto.
      output = process.communicate()[0] # Read what came out so far
      # Print a notice and the first bit of output
      return("Program timed out after {} seconds. Output up to this point was:\n\n"\
             .format(timeout).encode('utf-8') + output[0:5000])

def readfile(filename):
  """ read a file's contents into a string. """
  f = open(filename)
  s = f.read()
  f.close()
  return s

def show_problem(problem):
  prompt = readfile("problems/{}/prompt".format(problem))
  startercode = readfile("problems/{}/startercode".format(problem))
  page = """<html>
<meta charset="UTF-8"> 
<head>

<style type="text/css" media="screen">
    #editor { 
        width: 800px;
        height: 400px;
    }
</style>

<script>
function compile() {

  // Read the code from the form
  var code = editor.getValue();

  // Send the code to the server
  if (code.length == 0) {
      document.getElementById("txtHint").innerHTML = "";
      return;
  } else {
      var xmlhttp = new XMLHttpRequest();
      xmlhttp.onreadystatechange = function() {
          if (this.readyState == 4 && this.status == 200) {
              document.getElementById("buildlog").innerHTML = "<pre>" + this.responseText + "</pre>";
          }
      };
      xmlhttp.open("POST", "/compile/""" + problem + """", true);
	    //xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      xmlhttp.send(code);
  }
}

function saveFile( ) {
	var editor = ace.edit("editor");
	var filename = "testfile.vhdl";
	var data = editor.getValue();
    	var file = new Blob([data], {type: "text/plain"});
    	if (window.navigator.msSaveOrOpenBlob) // IE10+
        	window.navigator.msSaveOrOpenBlob(file, filename);
    	else { // Others
        	var button = document.getElementById("save");
                url = URL.createObjectURL(file);
        	button.href = URL.createObjectURL(file);
        	button.download = filename;
    }
}


</script>
</head>
<body>""" + prompt + \
"""<br/>
<div id="editor">
""" + \
startercode + \
"""</div>

<script src="/ace-builds/src-noconflict/ace.js" type="text/javascript" charset="utf-8"></script>
<script>
    var editor = ace.edit("editor");
    editor.setTheme("ace/theme/solarized_light");
    editor.session.setMode("ace/mode/vhdl");
    document.getElementById("editor").style.fontSize='16px';
</script>

<button onClick="compile()">Build!</button>

<a id = "save">
<button  onClick="saveFile()"> Download File </button>
</a>

<p>Build output:<br/>
  <span id="buildlog"></span></p>

</body>
</html>
"""
  return page


def findpath():
  """ Create a unique temporary working directory and return the path to it. """
  wdir = None
  while wdir is None:
    # Pick a number
    idnum = random.randint(0, 10000)
    # Check if it already exists
    tmpdir = '/tmp/vhdlweb-www/{}'.format(idnum)
    if not os.path.isdir(tmpdir):
      # If not, make it and claim it
      os.mkdir(tmpdir)
      wdir = tmpdir

  return wdir + '/'

def compile(wdir, problem):
    # Copy the files into the working directory
    safe_run(["cp", "/var/www/vhdlweb/problems/{}/Makefile".format(problem), wdir])
    safe_run(["cp", "/var/www/vhdlweb/problems/{}/testbench.vhd".format(problem), wdir])
    
    # Try to jam it through GHDL and capture the result
    output = safe_run(["make", "-f", wdir + "Makefile", "--directory", wdir, "--silent"], stderr = sp.STDOUT)

    return(output)


def application(environ, start_response):
    status = '200 OK'
    response_type = 'text/plain'

    # Quick hack to print the environment
    # output = [
    #     '%s: %s' % (key, value) for key, value in sorted(environ.items())
    # ]
    # output = '\n'.join(output)
 
    uri = environ['REQUEST_URI'].strip('/').split('/')
    request = None
    if len(uri) >= 2:
        request = uri[0] # Either "problem" or "compile"
        problem = uri[1]

    if request == "problem":
        output = show_problem(problem).encode('utf-8')
        response_type = 'text/html'

    elif request == "compile" and environ['REQUEST_METHOD'] == 'POST':
        # Get the POST content from the form
        try:
            length = int(environ['CONTENT_LENGTH'])
        except ValueError:
            length = 0;
        if length > 0:
            code = environ['wsgi.input'].read(length)
            wdir = findpath()
            fp = open(wdir + 'submission.vhd', 'w')
            fp.write(code.decode('utf-8'))
            fp.close()
            output = compile(wdir, problem)
        else:
            output = b"Failed to parse HTTP request."

    else:
        # TODO: set to 404?
        output = b"Page not found."

    response_headers = [('Content-type', response_type),
                        ('Content-Length', str(len(output)))]
    start_response(status, response_headers)

    return [output]

if __name__ == '__main__':
  pass
  #print(compile())

