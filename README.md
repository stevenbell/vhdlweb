# vhdlweb
Learn VHDL by example in a web browser (for Tufts ES 4 and EE 201)

Requires flask, flask-markdown, and gunicorn, install using pip:
`pip install flask flask-markdown gunicorn`.

Must also have [GHDL](https://github.com/ghdl/ghdl) installed (not required when using docker).

Must also have [docker](https://www.docker.com/) installed. Will automatically pull/update image.

Make sure you have an appropriate `deploy.config` and `debug.config` before running `deploy` and `debug`, respectively.

Useful resources:
* https://www.vultr.com/docs/how-to-setup-gunicorn-to-serve-python-web-applications

## Docker

Pull the latest GHDL docker image using:
```
docker pull ghdl/ghdl:buster-gcc-8.3.0
```

Pass in files/folders to a docker container by doing:
```
docker run -v /local/path/to/folder:/container/path/to/folder <container> [command]
```

Automatically delete a container when finished by passing in `--rm`:
```
docker run --rm <container> [command]
```

To run GHDL from docker, do:
```
docker run ghdl/ghdl:buster-gcc-8.3.0 ghdl <stuff>
```
