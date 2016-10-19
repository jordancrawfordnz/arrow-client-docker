FROM schickling/rust
USER root

RUN apt-get update && apt-get install -y git libssl-dev libpcap-dev

# Install the Arrow client.
WORKDIR "/"
RUN git clone https://github.com/angelcam/arrow-client
WORKDIR "/arrow-client"
RUN cargo build --release --features "discovery"

# Setup the Arrow client.
RUN mkdir /etc/arrow && cp mjpeg-paths /etc/arrow/mjpeg-paths && cp rtsp-paths /etc/arrow/rtsp-paths
RUN mkdir /var/lib/arrow
RUN mv /arrow-client/target/release/arrow-client /usr/bin
RUN mv /arrow-client/ca.pem /etc/arrow
WORKDIR "/"
RUN rm -rf /arrow-client

VOLUME ["/arrow-config"]

ENTRYPOINT ["arrow-client", "arr-rs.angelcam.com:8900", "-c", "/usr/share/ca-certificates", "-c", "/etc/arrow/ca.pem", "--config-file=/arrow-config/config.json"]
