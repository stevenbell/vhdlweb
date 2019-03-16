from flask import Flask, render_template, request, jsonify

import subprocess as sp
import random
import os, fnmatch
import sys
import cgi

app = Flask(__name__, static_url_path="/public/")


@app.route("/compile/", methods=["POST"])
def compile_vhdl():
    data = request.get_json()
    code = data["code"]
    problem = data["problem"]
    print(problem)
    length = len(code)
    output = b"Failed to parse HTTP request."
    if (length > 0):
        wdir = findpath()
        fp = open(wdir + "submission.vhd", "w")
        fp.write(code);
        fp.close()
        output = compile(wdir, problem)
        print(output)
    return jsonify({ "output": "output" })


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

def compile(wdir, problem):
    print(os.listdir("problems/{}".format("abc")))
    safe_run(["cp", "/var/www/problems/{}/Makefile".format(problem), wdir])
    safe_run(["cp", "/var/www/problems/{}/testbench.vhd".format(problem), wdir])

    # Try to jam it through GHDL and capture the result
    output = safe_run(["make", "-f", wdir + "Makefile", "--directory", wdir, "--silent"], stderr = sp.STDOUT)

    return(output)

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
      os.makedirs(tmpdir)
      wdir = tmpdir
  return wdir + '/'


def readfile(filename):
  f = open(filename)
  s = f.read()
  f.close()
  return s


@app.route("/problem/<problem>/", methods=["GET"])
def show_editor(problem):
  cwd = os.getcwd()
  print(cwd)
  print(os.listdir(cwd))
  prompt = readfile("problems/{}/prompt".format(problem))
  startercode = readfile("problems/{}/startercode".format(problem))
  problem_to_compile = problem
  return render_template('editor.html', message={"prompt": prompt, \
  "startercode": startercode, "problem" : problem } )



@app.route('/')
def display_problems():
    return render_template('index.html')
