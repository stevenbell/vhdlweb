# Directory structure
Each problem is placed in a directory with several files:
* `config` - A JSON file containing the problem configuration.  For now, this is primarily a list of files to be copied into the build directory.  This includes the Makefile, testbench VHDL file(s), and any necessary data files.
* `prompt` - This is a description of the problem, which is placed above the code window.  The file can be formatted with Markdown, and you can also include arbitrary HTML.  MathJax is supported for equations, but due to the Markdown processing, you'll have to escape the `\` like so: `\\(MATHJAX HERE\\)`
* `startercode` - The starter code that is presented in the editor when the problem is first opened.
* `Makefile` - Builds and runs the testbench.  While the Makefile can have as many rules as you'd like, `make all` should execute the test.

The student's code will be saved as `submission.vhd`.

# Testbench
* VHDLweb assumes the build was successful if the file `work-obj08.cf` was created.
* The test will be considered successful if the simulation emits the line `TEST PASSED`, and did not emit the word `fail`.  This makes it hard enough for students to fake a passing test that they'd be better off solving the problem directly.

