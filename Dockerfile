FROM schickling/rust

RUN apt-get update && apt-get install -y git openssl libpcap0.8-dev

RUN cd /source && git clone https://github.com/angelcam/arrow-client
RUN cd /source/arrow-client && cargo build --release --features "discovery"
RUN mkdir /etc/arrow && cp mjpeg-paths /etc/arrow/mjpeg-paths && cp rtsp-paths /etc/arrow/rtsp-paths
