# references:
# - https://www.balena.io/docs/learn/develop/dockerfile/
# - https://hub.docker.com/r/balenalib/raspberry-pi2-python/tags
# FROM balenalib/%%BALENA_MACHINE_NAME%%-python:3.4-jessie-build-20190717
FROM balenalib/amd64-python:3.4-jessie-build-20190717

RUN install_packages \
    bluetooth \
    libbluetooth-dev \
    libboost-python-dev \
    libboost-thread-dev \
    libglib2.0-dev \
    pkg-config \
    python-dev

WORKDIR /usr/src/app

# We copy and install 'requirements.txt' first, because it is less likely to
# change than other source code, and so we can better utilize caching.
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY . ./

# Enable udevd so that plugged dynamic hardware devices show up in our container.
ENV UDEV=1

CMD ["python","-u","app.py"]
