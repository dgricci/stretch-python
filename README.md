% Environnement Python  
% Didier Richard  
% 2018/08/30

---

revision:
- 1.0.0 : 2018/08/30  

---

# Building #

```bash
$ docker build -t dgricci/python:$(< VERSION) .
$ docker tag dgricci/python:$(< VERSION) dgricci/python:latest
```

## Behind a proxy (e.g. 10.0.4.2:3128) ##

```bash
$ docker build \
    --build-arg http_proxy=http://10.0.4.2:3128/ \
    --build-arg https_proxy=http://10.0.4.2:3128/ \
    -t dgricci/python:$(< VERSION) .
$ docker tag dgricci/python:$(< VERSION) dgricci/python:latest
```

## Build command with arguments default values : ##

```bash
$ docker build \
    --build-arg PYTHON_VERSION=3.6.6 \
    --build-arg PYTHON_DOWNLOAD_URL=https://www.python.org/ftp/python/$PYTHON_VERSION/Python-3.6.6.tar.xz \
    --build-arg PYTHON_PIP_VERSION=18.0 \
    --build-arg PYTHON_PIP_DOWNLOAD_URL=https://bootstrap.pypa.io/get-pip.py \
    -t dgricci/python:$(< VERSION) .
$ docker tag dgricci/python:$(< VERSION) dgricci/python:latest
``` 

# Use #

See `dgricci/stretch` README for handling permissions with dockers volumes.

```bash
$ docker run -it --rm dgricci/python:$(< VERSION)
Python 3.6.6
pip 18.0 from /usr/local/lib/python3.6/site-packages/pip (python 3.6)
```

__Et voilà !__


_fin du document[^pandoc_gen]_

[^pandoc_gen]: document généré via $ `pandoc -V fontsize=10pt -V geometry:"top=2cm, bottom=2cm, left=1cm, right=1cm" -s -N --toc -o python.pdf README.md`{.bash}

