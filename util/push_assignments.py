# Take a list of assignments and a roster, and adds the assignments to the custom
# assignment list for each student in the roster (if they don't exist already).
# If the assignment list doesn't exist, it is created.
import json
import os
from sys import argv

if len(argv) < 3:
  print("USAGE: push_assignments.py ROSTER ASSIGNMENTS")
  exit()

rosterpath = argv[1]
updatefile = argv[2] # File with new problems to add

datapath = '/home/vhdlweb/vhdlweb_data/' # Account directories live in here

updates = json.load(open(updatefile))

rosterfile = open(rosterpath)
accounts = [l.strip() for l in rosterfile]

for account in accounts:
  assignmentpath = datapath + account + '/assignments.json'
  if os.path.isfile(assignmentpath):
    try:
      current_assignments = json.load(open(assignmentpath))
    except Exception as e:
      print("Error loading assignment file for {}, skipping it.".format(account))
      print(e)
      continue # Skip to next; we don't want to overwrite if we can't read its current contents
  else:
    current_assignments = {}

  # `dict` is order-preserving as of Python 3.7, so we don't have to do anything
  # special to keep the assignments in order when updating and writing the file back.
  current_assignments.update(updates)

  try:
    json.dump(current_assignments, open(assignmentpath, 'w'))
  except Exception as e:
    print("Error writing assignment file for {}.  Something may be broken.".format(account))
    print(e)

print("Updates complete!")

