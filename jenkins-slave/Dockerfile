FROM jenkinsci/jnlp-slave:2.52

MAINTAINER Anas ASO <aso.anas@protonmail.com>

USER root

# Docker group on GKE nodes always has the ID 450.
RUN groupadd --gid 450 docker

RUN adduser jenkins docker

USER jenkins
