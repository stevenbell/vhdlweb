from flask import Flask, render_template, request, session, redirect, url_for, flash
from flaskext.markdown import Markdown
from logging import FileHandler, Formatter
import json
import time
import re
import os
from random import choices
from string import ascii_letters
from vhdlweb_build import * 

app = Flask(__name__)
app.config.from_envvar('VHDLWEB_CONFIG')

# Set up Flask to log errors to a file (in addition to the console by default)
filelog_handler = FileHandler('vhdlweb_errors.log')
filelog_handler.setFormatter(Formatter('[%(asctime)s] %(levelname)s in %(module)s: %(message)s'))
app.logger.addHandler(filelog_handler)

# Set up the Markdown extension
md = Markdown(app, extensions=['fenced_code'])

def readfile(filename):
  """ Read a file's contents into a string. """
  f = open(filename)
  s = f.read()
  f.close()
  return s

def get_user(session):
  """ Returns the identifier for this user.  If the user is not logged in,
      returns a temporary identifier. """
  if 'username' in session:
    return session['username']
  elif 'tempId' in session:
    return session['tempId']
  else:
    tempId = "".join(choices(ascii_letters, k=25))
    session['tempId'] = tempId
    return tempId

def logged_in(session):
  """ Returns true if the user is logged in (and has a valid submission directory).
      Returns false if the user just has a temporary identifier. """
  return 'username' in session

@app.route('/')
def index():
  return render_template('index.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
  if request.method == 'POST':
    # If it's a POST, then validate the info and log the user in
    username = request.form['username']
    password = request.form['password']

    if re.search("^[a-zA-Z0-9\._\-]+$", username) is None:
        flash("That username or password is incorrect.")
        return render_template('login.html')

    pwfile = app.config['WORKDIR'] + '/' + username + '/password'
    if os.path.isfile(pwfile) and readfile(pwfile).strip() == password:
      session['username'] = username
      return redirect('assignments')

    else:
      flash("That username or password is incorrect.")
      return render_template('login.html')

  # If it's a GET, show the login page
  return render_template('login.html')

@app.route('/logout')
def logout():
  # Just delete the username cookie and send them back to the home page
  session.pop('username')
  return redirect(url_for('index'))

@app.route('/reference')
def reference():
  return render_template('reference.html')

@app.route('/assignments')
def showAssignments():
  if logged_in(session):
    username = get_user(session)
    assignment_file = app.config['WORKDIR'] + '/' + username + '/assignments.json'
    try:
      assignments = json.load(open(assignment_file))
    except:
      # If we couldn't find the user's assignments file, or it was corrupt, then
      # don't put any problems.  This will make the error obvious, rather than
      # masking the problem with some default assignment file.
      assignments = {"You appear to have no assignments. Contact the teaching staff.":[]}
  else:
    assignments = json.load(open('data/assignments.json'))

  return render_template('assignments.html', assignments = assignments)

def mark_assignment(username, assignmentId):
  assignment_file = app.config['WORKDIR'] + '/' + username + '/assignments.json'
  try:
    assignments = json.load(open(assignment_file))
    for section in assignments:
      for idx,problem in enumerate(assignments[section]):
        if problem['id'] == assignmentId:
          assignments[section][idx]['status'] = 'complete'
          json.dump(assignments, open(assignment_file, 'w'))
  except Exception as e:
    current_app.logger.error("failed to mark problem complete for student :\n" + str(e))

@app.route('/compile/<problemId>', methods=['POST'])
def compilerequest(problemId):
  if request.method == 'POST':
    requestblob = request.json

    username = get_user(session)
 
    timestamp = time.ctime()

    # Get a working directory for this submission
    wdir = findpath(app.config['WORKDIR'], username, problemId)

    # Write the code file into the directory
    codefile = open(wdir + '/submission.vhd', 'w')
    codefile.write(requestblob['code'])# code.decode('utf-8')
    codefile.close()

    # Copy build files and execute the build
    output = runtest(wdir, problemId)

    # Write a metadata file into the directory
    # Username/problem are captured by the directory name
    metadata = {'button':requestblob['button'],
                'pagetime':requestblob['pagetime'],
                'pastes':requestblob['pastes'],
                'time':timestamp,
                'status':output['status'] }
    metafile = open(wdir + '/metadata.json', 'w')
    json.dump(metadata, metafile)
    metafile.close()

    # Send the result plus a little more metadata back
    submissionId = wdir.strip('/').rsplit('/', 1)[-1]
    output.update({"timestamp":timestamp, "submissionId":submissionId})

    problem_config = json.load(open(app.config['SRCDIR'] + '/' + problemId + '/config'))
    if ('netlist' in problem_config and problem_config['netlist'] == "yes" and output['status'] != "buildfail"):
      output.update({'netlist':'/netlist/' + problemId + '/' + submissionId})

    if output['status'] == 'pass' and logged_in(session):
      mark_assignment(username, problemId)
    return json.dumps(output)

@app.route('/netlist/<problemId>/<subId>')
def generateNetlist(problemId, subId):
  # If the problem exists
  if not os.path.isdir(app.config['SRCDIR'] + '/' + problemId):
    return "Problem {} not found.".format(problemId), 404

  # and the config says we can make netlists
  problem_config = json.load(open(app.config['SRCDIR'] + '/' + problemId + '/config'))
  if not ('netlist' in problem_config and problem_config['netlist'] == "yes"):
    return "Problem {} does not support netlist generation".format(problemId), 404

  # and the submission exists
  wdir = app.config['WORKDIR'] + '/' + get_user(session) + '/' + problemId + '/' + subId + '/'
  sub_metapath = wdir + 'metadata.json'
  if not os.path.isfile(sub_metapath):
    return "Submission {} not found".format(subId), 404

  # and the submission built successfully
  metadata = json.load(open(sub_metapath))
  if metadata['status'] == 'buildfail':
    return "Netlist not available because synthesis failed", 404

  # then try to generate the netlist!
  try:
    run_netlist(wdir)
    headers = {'Content-Type':'image/svg+xml'}
    return (readfile(wdir + "netlist.svg"), headers)
  except Exception as e:
    current_app.logger.error("netlist generation error with wdir=" + wdir + " :\n" + str(e))
    return "Error generating netlist", 500

@app.route('/submission/<problemId>/<subId>')
def retrieveSubmission(problemId, subId):
  if subId == 'startercode':
    return readfile("data/problems/{}/startercode".format(problemId))
  else:
    subpath = app.config['WORKDIR'] + '/' + get_user(session) + '/' + problemId + '/' + subId + '/submission.vhd'
    if os.path.isfile(subpath):
      return readfile(subpath)
    else:
      return "Submission {} not found".format(subId), 404

@app.route('/problem/<problemId>')
def showProblem(problemId):
  prompt = readfile("data/problems/{}/prompt".format(problemId))

  # Build a list of the submissions
  basepath = app.config['WORKDIR'] + '/' + get_user(session) + '/' + problemId
  submissions = []
  subdir = '0000' # Start at zero and count up

  while os.path.isdir(basepath + '/' + subdir):

    subdata = json.load(open(basepath + '/' + subdir + '/metadata.json'))
    submissions.append({'id':subdir, 'status':subdata['status'], 'time':subdata['time']})

    # Find the next one
    subdir = '{:04d}'.format(len(submissions))

  # Reverse the list, so the most recent are first
  submissions.reverse()

  if len(submissions) > 0:
    # If the user has already tried this problem, give them their last attempt
    startercode = readfile(basepath + '/' + submissions[0]['id'] + '/submission.vhd')

  else:
    # Otherwise, use the starter code
    startercode = readfile("data/problems/{}/startercode".format(problemId))

  # Finally, put the starter code in the list
  submissions.append({'id':'startercode', 'status':'new', 'time':'Starter code'})

  return render_template('problem.html', problemId=problemId, prompt=prompt, submissions=submissions, startercode=startercode)

# https://stackoverflow.com/a/29516120
@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404
