FROM jenkins/jnlp-slave:3.27-1

# Switch to root to install packages.
USER root

# Install Docker
RUN apt-get update && \
    apt-get install --yes \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg2 \
        software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
        stable" && \
    apt-get update && \
    apt-get install --yes docker-ce docker-ce-cli containerd.io && \
    apt-get clean

# Install kubectl
RUN curl -s -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin

# Install Helm
RUN curl -O -s https://get.helm.sh/helm-v2.16.1-linux-amd64.tar.gz && \
    tar -zxvf helm-v2.16.1-linux-amd64.tar.gz && \
    mv linux-amd64/helm /usr/local/bin/helm && \
    rm -rf linux-amd64 helm-v2.16.1-linux-amd64.tar.gz

# Install Golang
RUN curl -O -s https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz && \
    tar -zxvf go1.13.5.linux-amd64.tar.gz && \
    chown -R root:root ./go && \
    mv go /usr/local && \
    rm -f go1.13.5.linux-amd64.tar.gz

ENV PATH=$PATH:/usr/local/go/bin

USER jenkins
