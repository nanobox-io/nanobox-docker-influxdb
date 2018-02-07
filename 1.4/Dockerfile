FROM nanobox/runit

# Create directories
RUN mkdir -p \
  /var/log/gonano \
  /var/nanobox \
  /opt/nanobox/hooks

# Install influxdb
RUN wget -O /tmp/influxdb.deb https://dl.influxdata.com/influxdb/releases/influxdb_1.4.3_amd64.deb && \
    dpkg -i /tmp/influxdb.deb && \
    rm /tmp/influxdb.deb

# Install kapacitor
RUN wget -O /tmp/kapacitor.deb https://dl.influxdata.com/kapacitor/releases/kapacitor_1.4.0_amd64.deb && \
    dpkg -i /tmp/kapacitor.deb && \
    rm /tmp/kapacitor.deb

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
      https://s3.amazonaws.com/tools.nanobox.io/hooks/influxdb-mimir.tgz \
        | tar -xz -C /opt/nanobox/hooks

# Download hooks md5 (used to perform updates)
RUN curl \
      -f \
      -k \
      -o /var/nanobox/hooks.md5 \
      https://s3.amazonaws.com/tools.nanobox.io/hooks/influxdb-mimir.md5 && \
    curl \
      -f \
      -k \
      -L \
      -o /data/bin/mimir \
      https://www.dropbox.com/s/1s344gutcqsh1hx/mimir?dl=1 && \
    chmod +x /data/bin/mimir

# Run runit automatically
CMD [ "/opt/gonano/bin/nanoinit" ]
