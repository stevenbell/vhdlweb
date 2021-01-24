
# Planned improvements for 2021
* Add quick VHDL reference popup available from any problem page

* Get VHDL -> netlistsvg working; add a flag to enable schematic generation for most problems
* Add "write code to create this circuit" problems

* Allow users to download the VCD (to display/analyze locally with gtkwave)
  Log when students download the VCD for research purposes
  The VCDs can get *really* big, so 

# Research metrics/improvements
* Add "what's this" tooltip(s) to buttons to explain what the various options mean

# Security/robustness
* Implement docker containers for sandboxing?
* Sanitize the input.  VHDL file operations shouldn't be allowed, for obvious security reasons
* Check that the python code actually times out after 5s if the simulation doesn't stop on its own, and return some helpful message to the user.

# Wishlist
* Nicer 404 error page
* Allow user to select options for ACE editor (Vim/Emacs bindings, color scheme)
* Fix Ace syntax highlighting for VHDL: 'or' is a keyword

# Cool things to do later
* Figure out how to display waveforms from a VCD (value change dump) file.  We could generate an SVG on the backend and send it up, or draw it dynamically with JS.

* Run the design through synthesis (yosys or lscc) and estimate the size of the design; have a leaderboard for the smallest designs which meet the required functionality.

