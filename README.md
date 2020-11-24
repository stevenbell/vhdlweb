# vhdlweb
Learn VHDL by example in a web browser (for Tufts ES 4 and EE 201)

Requires flask, flask-markdown, and gunicorn, install using pip:
`pip install flask flask-markdown gunicorn`.

Must also have [GHDL](https://github.com/ghdl/ghdl) installed.

Make sure you have an appropriate `deploy.config` and `debug.config` before running `deploy` and `debug`, respectively.

Useful resources:
* https://www.vultr.com/docs/how-to-setup-gunicorn-to-serve-python-web-applications
