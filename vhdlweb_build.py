import subprocess as sp
import re
import os

SRCDIR="/home/steven/Documents/teaching/es4/vhdlweb/data/problems"
WORKDIR="/tmp/vhdlweb"

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

def findpath(student, problemId):
  """ Create a unique temporary working directory corresponding to this student
      and problem, and return the path to it. """
  basepath = WORKDIR + '/' + student + '/' + problemId
  if not os.path.isdir(basepath):
    os.mkdir(basepath)

  existingsubs = os.listdir(basepath)

  if len(existingsubs) > 0:
    existingsubs.sort() # Sort them so that last is the most recent
    lastsub = int(existingsubs[-1]) # Get the number of the last submission
    subdir = '{:04d}'.format(lastsub + 1) # Increment and write it with 4 digits
  else:
    subdir = '0000' # Use leading zeros for easy sorting

  wdir = basepath + '/' + subdir

  # Make the directory and use it
  os.mkdir(wdir)
  return wdir + '/'

def compile(wdir, problem):
    # Copy the files into the working directory
    try:
      filelist = open("{path}/{problem}/filelist".format(path=SRCDIR, problem=problem))
      for filename in filelist:
        safe_run(["cp", "{path}/{problem}/{filename}".format(path=SRCDIR, problem=problem, filename=filename.strip()), wdir])

      # Try to jam it through GHDL and capture the result
      output = safe_run(["make", "-f", wdir + "Makefile", "--directory", wdir, "--silent", "GHDL=/home/steven/tools/ghdl/ghdl_mcode"], stderr = sp.STDOUT)
      output = output.decode('utf-8')
    except:
      output = "A server error occured while compiling your code."

    # If the build file was created, then assume build succeeded
    buildOk = os.path.isfile(wdir + "work-obj08.cf")

    # See if the testbench emitted a "TEST PASSED" line
    matches = re.findall('^testbench\.vhd.*TEST PASSED', output, flags=re.M)
    testPassed = len(matches) is 1

    if buildOk and testPassed:
      status = "pass"
    elif buildOk:
      status = "testfail"
    else:
      status = "buildfail"

    return {"status":status, "buildOutput":output}
    return output

