#!/bin/bash

## Dockerfile for python environment

# install compiler environment (See dgricci/compilers) :
01-install.sh

# Exit on any non-zero status.
trap 'exit' ERR
set -E

# install
apt-get install -y --no-install-recommends \
        libssl-dev xz-utils tk-dev

# Try different servers as one can be timed out :
for server in ha.pool.sks-keyservers.net \
    hkp://p80.pool.sks-keyservers.net:80 \
    keyserver.ubuntu.com \
    hkp://keyserver.ubuntu.com:80 \
    pgp.mit.edu ; do
    gpg --keyserver "${server}" --recv-keys 0D96DF4D4110E5C43FBFB17F2D347EA6AA65421D && break || echo "Trying new server..."
done
curl -fsSL "${PYTHON_DOWNLOAD_URL}" -o python.tar.xz
curl -fsSL "${PYTHON_DOWNLOAD_URL}.asc" -o python.tar.xz.asc
gpg --batch --verify python.tar.xz.asc python.tar.xz
rm -f python.tar.xz.asc
mkdir -p /usr/src/python
tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz
rm -f python.tar.xz

echo "Compiling Python ${PYTHON_VERSION} ..."
cd /usr/src/python
gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)"
./configure --build="$gnuArch" --enable-loadable-sqlite-extensions --enable-shared --with-system-expat --with-system-ffi --without-ensurepip
make -j "$(nproc)"
make install
ldconfig
cd /
find /usr/local -depth \
    \( \
        \( -type d -a \( -name test -o -name tests \) \) \
        -o \
        \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
    \) -exec rm -rf '{}' \;
rm -rf /usr/src/python
python3 --version

# make some useful symlinks that are expected to exist
cd /usr/local/bin
ln -s idle3 idle
ln -s pydoc3 pydoc
ln -s python3 python
ln -s python3-config python-config

echo "Installing pip ${PYTHON_PIP_VERSION} ..."
wget -O get-pip.py "${PYTHON_PIP_DOWNLOAD_URL}"
python get-pip.py --disable-pip-version-check --no-cache-dir "pip==$PYTHON_PIP_VERSION"
rm -f get-pip.py
find /usr/local -depth \
    \( \
        \( -type d -a \( -name test -o -name tests \) \) \
        -o \
        \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
    \) -exec rm -rf '{}' \;
pip --version

# uninstall and clean
01-uninstall.sh y

exit 0

