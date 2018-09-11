## Dockerfile for python
## See https://github.com/docker-library/python/blob/878ffe36c2391279e673a44a011f5c65943b5eb8/3.6/jessie/Dockerfile
FROM dgricci/dev:1.0.0
MAINTAINER Didier Richard <didier.richard@ign.fr>
LABEL       version="1.0.0" \
            python="3.6.6" \
            pip="18.0" \
            os="Debian Stretch" \
            description="Python, pip"

ARG PYTHON_VERSION
ENV PYTHON_VERSION ${PYTHON_VERSION:-3.6.6}
ARG PYTHON_DOWNLOAD_URL
ENV PYTHON_DOWNLOAD_URL ${PYTHON_DOWNLOAD_URL:-https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.xz}
ARG PYTHON_PIP_VERSION
ENV PYTHON_PIP_VERSION ${PYTHON_PIP_VERSION:-18.0}
ARG PYTHON_PIP_DOWNLOAD_URL
ENV PYTHON_PIP_DOWNLOAD_URL ${PYTHON_PIP_DOWNLOAD_URL:-https://bootstrap.pypa.io/get-pip.py}

COPY build.sh /tmp/build.sh
RUN /tmp/build.sh && rm -f /tmp/build.sh

# default command : prints python version and exits
CMD python --version && pip --version

