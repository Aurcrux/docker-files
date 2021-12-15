FROM debian:bullseye

MAINTAINER Anas ASO <aso.anas@protonmail.com>

RUN \
    bash -c 'echo -e "deb http://httpredir.debian.org/debian bullseye main contrib\ndeb http://httpredir.debian.org/debian bullseye-updates main\ndeb http://security.debian.org/debian-security bullseye-security main contrib non-free" > /etc/apt/sources.list' && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install wget curl java-package libgl1-mesa-glx libgtk-3-dev libxslt1.1 libxtst6 libxxf86vm1 -y --fix-missing && \
    useradd -ms /bin/bash java-packager

USER java-packager

WORKDIR /workdir

VOLUME ["/workdir"]

CMD ["--help"]

ENTRYPOINT ["make-jpkg"]
