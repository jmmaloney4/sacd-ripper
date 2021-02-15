FROM ubuntu:20.04

RUN apt-get update; apt-get -y install cmake libc6-dev; apt-get -y upgrade; apt-get -y autoremove

COPY . /root/sacd-ripper
WORKDIR /root/sacd-ripper/tools/sacd_extract/
RUN cmake .; make

FROM ubuntu:20.04
RUN mkdir -p /root/bin/
COPY --from=0 /root/sacd-ripper/tools/sacd_extract/sacd_extract /root/bin/sacd_extract
ENTRYPOINT ["/root/bin/sacd_extract"]