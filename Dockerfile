# Pull base image.
FROM ubuntu:14.04

# Install Redis.
RUN \
  apt-get update && \
  apt-get -y install wget build-essential && \
  cd /tmp && \
  wget http://download.redis.io/redis-stable.tar.gz && \
  tar xvzf redis-stable.tar.gz && \
  cd redis-stable && \
  make && \
  make install && \
  cp -f src/redis-sentinel /usr/local/bin && \
  mkdir -p /etc/redis && \
  rm -rf /tmp/redis-stable*

ADD . /etc/redis/

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Expose ports.
EXPOSE 6379

# Define default command.
CMD ["redis-server", "/etc/redis/redis.conf"]

