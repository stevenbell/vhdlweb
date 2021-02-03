from flask import current_app
import subprocess as sp
import re
import os

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

def findpath(workdir, student, problemId):
  """ Create a unique temporary working directory corresponding to this student
      and problem, and return the path to it. """
  # Check that the student directory exists and create it if necessary
  # This should only happen for anonymous users
  studentpath = workdir + '/' + student
  if not os.path.isdir(studentpath):
    os.makedirs(studentpath)

  # Check that the problem subdirectory exists and create it if necessary
  # This will happen the first time a user attempts a problem
  basepath = studentpath + '/' + problemId
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

def runtest(wdir, problem):
    """
    Copy the files for a problem into a working directory, try to build it and
    run the test, and report the result.
    The app object must have SRCDIR (the problem source) and MAKE_ARGS (extra
        command line args for Make) defined.
    wdir: The working directory to copy to and build in
    problem: the id for the problem we're working on
    """

    # Copy the files into the working directory
    try:
      filelist = open("{path}/{problem}/filelist".format(path=current_app.config['SRCDIR'], problem=problem))
      for filename in filelist:
        safe_run(["cp", "{path}/{problem}/{filename}".format(path=current_app.config['SRCDIR'], problem=problem, filename=filename.strip()), wdir])

        # Try to jam it through docker GHDL and capture the result
      command = ["docker", "run", "--rm", "-v", wdir + ":" + wdir, current_app.config["DOCKER_IMAGE"]]
      safe_run(["docker", "pull", current_app.config["DOCKER_IMAGE"]])
      output = safe_run(command + ["make", "-f", wdir + "Makefile", "--directory", wdir, "--silent"] + current_app.config['MAKE_ARGS'], stderr = sp.STDOUT)
      output = output.decode('utf-8')
    except Exception as e:
      current_app.logger.error("server error with wdir=" + wdir + " :\n" + str(e))
      output = "A server error occured while compiling your code."

    # If the build file was created, then assume build succeeded
    buildOk = os.path.isfile(wdir + "work-obj08.cf")

    # See if the testbench emitted a "TEST PASSED" line
    passMatches = re.findall('TEST PASSED', output)

    testPassed = len(passMatches) == 1

    if buildOk and testPassed:
      status = "pass"
    elif buildOk:
      status = "testfail"
    else:
      status = "buildfail"

    return {"status":status, "buildOutput":output}
    return output
