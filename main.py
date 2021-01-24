from flask import Flask, render_template, request, session, redirect, url_for, flash
from flaskext.markdown import Markdown
from logging import FileHandler, Formatter
import json
import time
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
    assignments = json.load(open('data/assignments.json'))
    # TODO: annotate this with the ones that are complete
  else:
    assignments = json.load(open('data/assignments.json'))

  return render_template('assignments.html', assignments = assignments)

@app.route('/compile/<problemId>', methods=['POST'])
def compilerequest(problemId):
  if request.method == 'POST':
    requestblob = request.json

    username = get_user(session)
 
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
                'changetext':requestblob['changetext'],
                'pagetime':requestblob['pagetime'],
                'pastes':requestblob['pastes'],
                'time':time.ctime(),
                'status':output['status'] }
    metafile = open(wdir + '/metadata.json', 'w')
    json.dump(metadata, metafile)
    metafile.close()

    # TODO: If the test passed, then mark this problem as complete
    return json.dumps(output)

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

