
# Security/robustness
* Sanitize the input.  VHDL file operations shouldn't be allowed, for obvious security reasons
* Check that the python code actually times out after 5s if the simulation doesn't stop on its own, and return some helpful message to the user.
* Make the installation more portable.  Short term, this would be just putting the configuration info into the top of the WSGI script or a separate file; long term this might mean developing a whole Docker image or something.

# Usability
* Actual 404 error message
* Some actual formatting and CSS (doesn't need to be fancy, and it should definitely be mobile friendly)
* Implement better formatting in the prompts.  Inline code snippets (or at least monospace font for code terms) would be nice, MathJAX might be helpful too.
* Implement vim/emacs as options for ACE editor

# New features
* Button to save file (or maybe just copy all contents to clipboard)

# Submission
* Figure out how we could use this for code submission, instead of needing `provide` on the side
  * Use a cookie to save the user's name, and just save this with the submission?
  * Timestampt the submission
* Integrate with Shibboleth for SSO

# Cool things to do later
* Figure out how to display waveforms from a VCD (value change dump) file.  We could generate an SVG on the backend and send it up, or draw it dynamically with JS.
* Allow multiple files (maybe a tabbed interface)
* Free-form sandbox

