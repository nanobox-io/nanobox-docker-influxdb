FROM nanobox/runit

# Create directories
RUN mkdir -p \
  /var/log/gonano \
  /var/nanobox \
  /opt/nanobox/hooks

# Install influxdb
RUN wget -O /tmp/influxdb_1.0.1_amd64.deb https://dl.influxdata.com/influxdb/releases/influxdb_1.0.1_amd64.deb && \
    dpkg -i /tmp/influxdb_1.0.1_amd64.deb && \
    rm /tmp/influxdb_1.0.1_amd64.deb

# Install rsync
RUN apt-get update -qq && \
    apt-get install -y rsync iputils-arping && \
    apt-get clean all && \
    rm -rf \
        /var/lib/apt/lists/* \
        /var/cache/apt/* \
        /tmp/* \
        /var/tmp/*

# Install hooks
RUN curl \
      -f \
      -k \
      https://d1ormdui8qdvue.cloudfront.net/hooks/influxdb-stable.tgz \
        | tar -xz -C /opt/nanobox/hooks

# Download hooks md5 (used to perform updates)
RUN curl \
      -f \
      -k \
      -o /var/nanobox/hooks.md5 \
      https://d1ormdui8qdvue.cloudfront.net/hooks/influxdb-stable.md5

# Run runit automatically
CMD [ "/opt/gonano/bin/nanoinit" ]
