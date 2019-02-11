import subprocess as sp
import random
import os
import sys
import cgi

def safe_run(command, timeout=5, **kwargs):
    """ Wrapper around check_output which handles timeouts and catches segfaults.
        A brief informative message is logged with the failure."""
    try:
        result = sp.check_output(command, timeout=timeout, **kwargs)

    except sp.CalledProcessError as e:
        if e.returncode == -sp.signal.SIGSEGV:
            return(b"Program segfaulted")
        else:
            # TODO: could check for error return value
            result = e.output
    except sp.TimeoutExpired as e:
            return(b"Program timed out after {} seconds".format(timeout))

    # Just leave the result as bytes, since that's what we gotta send out
    return result

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
<script>
function compile() {

  // Read the code from the form
  var code = document.getElementById("code").value;

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
</script>
</head>
<body>""" + prompt + \
"""<br/>
<textarea rows="20" cols="120" id="code" type="text">""" + \
startercode + \
"""</textarea>
<br/>

<button onClick="compile()">Build!</button>
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
    tmpdir = '/tmp/vhdlweb/{}'.format(idnum)
    if not os.path.isdir(tmpdir):
      # If not, make it and claim it
      os.mkdir(tmpdir)
      wdir = tmpdir

  return wdir + '/'

def compile(wdir, problem):
    # Copy the files into the working directory
    safe_run(["cp", "/home/vhdlweb/vhdlweb/problems/{}/Makefile".format(problem), wdir])
    safe_run(["cp", "/home/vhdlweb/vhdlweb/problems/{}/testbench.vhd".format(problem), wdir])
    
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

