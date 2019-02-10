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
            # We don't know what students will return from main, so assume
            # anything other than a segfault is ok.
            result = e.output
    except sp.TimeoutExpired as e:
            return(b"Program timed out after {} seconds".format(timeout))

    # Just leave the result as utf-8, since that's what we gotta send out
    return result

def findpath():
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

def compile(wdir):
    # Copy the files into the working directory
    safe_run(["cp", "/home/vhdlweb/vhdlweb/example_src/abc/Makefile", wdir])
    safe_run(["cp", "/home/vhdlweb/vhdlweb/example_src/abc/abc_test.vhd", wdir])
    
    # Try to jam it through GHDL and capture the result
    output = safe_run(["make", "-f", wdir + "Makefile", "--directory", wdir, "--silent"], stderr = sp.STDOUT)

    return(output)


def application(environ, start_response):
    status = '200 OK'

    # Get the POST content from the form
    if environ['REQUEST_METHOD'] == 'POST':
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
            output = compile(wdir)
        else:
            output = b'Empty or malformed HTML request.'

    else:
        output = b'Error receiving or parsing HTML request.'


    response_headers = [('Content-type', 'text/plain'),
                        ('Content-Length', str(len(output)))]
    start_response(status, response_headers)

    return [output]

if __name__ == '__main__':
  pass
  #print(compile())

