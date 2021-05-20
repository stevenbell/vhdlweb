# Take a list of assignments and a roster, and create a CSV file indicating
# the fraction of assignments a student completed before the deadline

import os
import json
from sys import argv

datapath = '/home/vhdlweb/vhdlweb_data/' # Account directories live in here

def list_submissions(student, problem):
  assignmentdir = datapath + student + '/' + problem
  if os.path.isdir(assignmentdir):
    return os.listdir(assignmentdir)
  else:
    return []

def get_submission(student, problem, subid):
  subpath = datapath + student + '/' + problem + '/' + subid + '/metadata.json'
  return json.load(open(subpath))

def parse_date(datestring):
  pass


if len(argv) < 3:
  print("USAGE: grade_assignment.py ROSTER ASSIGNMENTS")
  exit()

rosterpath = argv[1]
problemfile = argv[2] # File with problems to check, one on each line


rosterfile = open(rosterpath)
accounts = [l.strip() for l in rosterfile]

problems_to_check = [l.strip() for l in open(problemfile)]

print("id,grade")

for account in accounts:
  total_passed = 0
  last_time = ''
  for problem in problems_to_check:
    for subid in list_submissions(account, problem):
      sub = get_submission(account, problem, subid)

      if sub['status'] == "pass":
        total_passed += 1
        last_time = sub['time'] # Nasty hack, just use the last one as the "submission time"
        break # Quit going through submissions and move to the next problem

  print("{},{},{}".format(account, total_passed, last_time))

