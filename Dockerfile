FROM python:3.9.16-slim-buster

# Install the setup and dependencies for GDAL with Python bindings and Flask. The order matters.
RUN apt-get -y update && \
  apt-get install -y gdal-bin libgdal-dev python3-pip python3-gdal && \
  pip3 install Flask Flask-Shell2HTTP Flask-Executor waitress && \
  export CPLUS_INCLUDE_PATH=/usr/include/gdal && \
  export C_INCLUDE_PATH=/usr/include/gdal && \
  pip3 install setuptools==57.5.0 numpy && \
  pip3 install GDAL==$(gdal-config --version) --global-option=build_ext --global-option="-I/usr/include/gdal" && \
  mkdir /app

COPY . /app
WORKDIR /app
CMD python app.py