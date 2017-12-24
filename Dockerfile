FROM ingensi/dockbeat:latest

RUN apt-get clean && apt-get update && apt-get install -y --no-install-recommends \
    python-pip \
    jq && \
    apt-get -q autoremove && \
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin
 
RUN pip install yq 

RUN mv /etc/dockbeat/dockbeat.yml /etc/dockbeat/dockbeat.orig.yml && \
    yq -y '.logging.to_syslog = false' /etc/dockbeat/dockbeat.orig.yml > /etc/dockbeat/dockbeat.yml

ENTRYPOINT ["/usr/local/bin/dockbeat"]
CMD ["-e", "-c", "/etc/dockbeat/dockbeat.yml"]
