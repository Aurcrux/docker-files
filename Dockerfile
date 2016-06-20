FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install --yes --force-yes software-properties-common && \
    add-apt-repository --yes ppa:duplicity-team/ppa

RUN apt-get update && \
    apt-get upgrade --yes --force-yes && \
    apt-get install --yes --force-yes duplicity && \
    apt-get clean

WORKDIR /data/

CMD ["--help"]

ENTRYPOINT ["/usr/bin/duplicity"]
