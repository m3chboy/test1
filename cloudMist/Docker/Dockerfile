FROM ubuntu:18.04

LABEL maintainer="Muhe"

# Environment Variables
ENV HOME /root
ENV DEBIAN_FRONTEND=noninteractive


# Working Directory
WORKDIR /root
RUN mkdir ${HOME}/toolkit && \
    mkdir ${HOME}/wordlists

# Install Essentials
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    tmux \
    gcc \
    iputils-ping\
    git \
    vim \
    wget \
    awscli \
    tzdata \
    curl \
    make \
    nmap \
    whois \
    python \
    python-pip \
    python3 \
    python3-pip \
    perl \
    nikto \
    dnsutils \
    net-tools \
    zsh\
    nano\
    && rm -rf /var/lib/apt/lists/*

# Install Dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    # sqlmap
    sqlmap \
    # dirb
    dirb \
    # dnsenum
    cpanminus \
    # wfuzz
    python-pycurl \
    # knock
    python-dnspython \
    # massdns
    libldns-dev \
    # wpcscan
    libcurl4-openssl-dev \
    libxml2 \
    libxml2-dev \
    libxslt1-dev \
    ruby-dev \
    libgmp-dev \
    zlib1g-dev \
    # masscan
    libpcap-dev \
    # theharvester
    python3.7 \
    # joomscan
    libwww-perl \
    # hydra
    hydra \
    # dnsrecon
    dnsrecon \
    # zsh
    powerline\
    # zsh
    fonts-powerline\
    && rm -rf /var/lib/apt/lists/*

# tzdata
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

# configure python(s)
RUN python -m pip install --upgrade setuptools && python3 -m pip install --upgrade setuptools && python3.7 -m pip install --upgrade setuptools


# massdns
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/blechschmidt/massdns.git && \
    cd massdns/ && \
    make && \
    ln -sf ${HOME}/toolkit/massdns/bin/massdns /usr/local/bin/massdns

# masscan
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/robertdavidgraham/masscan.git && \
    cd masscan && \
    make && \
    ln -sf ${HOME}/toolkit/masscan/bin/masscan /usr/local/bin/masscan    

# altdns
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/infosec-au/altdns.git && \
    cd altdns && \
    pip install -r requirements.txt && \
    chmod +x setup.py && \
    python setup.py install

# teh_s3_bucketeers
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/tomdev/teh_s3_bucketeers.git && \
    cd teh_s3_bucketeers && \
    chmod +x bucketeer.sh && \
    ln -sf ${HOME}/toolkit/teh_s3_bucketeers/bucketeer.sh /usr/local/bin/bucketeer

# Recon-ng
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/lanmaster53/recon-ng.git && \
    cd recon-ng && \
    pip3 install -r REQUIREMENTS && \
    chmod +x recon-ng && \
    ln -sf ${HOME}/toolkit/recon-ng/recon-ng /usr/local/bin/recon-ng

# XSStrike
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/s0md3v/XSStrike.git && \
    cd XSStrike && \
    pip3 install -r requirements.txt && \
    chmod +x xsstrike.py && \
    ln -sf ${HOME}/toolkit/XSStrike/xsstrike.py /usr/local/bin/xsstrike

# go
RUN cd /opt && \
    wget https://go.dev/dl/go1.18.1.linux-amd64.tar.gz && \
    tar -xvf go1.18.1.linux-amd64.tar.gz && \
    rm -rf /opt/go1.18.1.linux-amd64.tar.gz && \
    mv go /usr/local 
ENV GOROOT /usr/local/go
ENV GOPATH /root/go
ENV PATH ${GOPATH}/bin:${GOROOT}/bin:${PATH}


# virtual-host-discovery
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/AlexisAhmed/virtual-host-discovery.git && \
    cd virtual-host-discovery && \
    chmod +x scan.rb && \
    ln -sf ${HOME}/toolkit/virtual-host-discovery/scan.rb /usr/local/bin/virtual-host-discovery

# bucket_finder
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/AlexisAhmed/bucket_finder.git && \
    cd bucket_finder && \
    chmod +x bucket_finder.rb && \
    ln -sf ${HOME}/toolkit/bucket_finder/bucket_finder.rb /usr/local/bin/bucket_finder


# s3recon
RUN pip3 install --upgrade setuptools && \
    pip3 install pyyaml pymongo requests s3recon

# subfinder
RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# whatweb
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/urbanadventurer/WhatWeb.git && \
    cd WhatWeb && \
    chmod +x whatweb && \
    ln -sf ${HOME}/toolkit/WhatWeb/whatweb /usr/local/bin/whatweb

# fierce
RUN python3 -m pip install fierce

# amass
RUN export GO111MODULE=on && \
    go install -v github.com/OWASP/Amass/v3/...@master

# S3Scanner
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/sa7mon/S3Scanner.git && \
    cd S3Scanner && \
    pip3 install -r requirements.txt


# ffuf
RUN go install github.com/ffuf/ffuf@latest

# httpx
RUN go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest


# gau
RUN go install github.com/lc/gau/v2/cmd/gau@latest

# nuclei 
RUN go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

# naabu
RUN apt install -y libpcap-dev && \
    go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest

# interact.sh
RUN go install -v github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest

# nuclei templates
RUN cd ${HOME} && \
    git clone https://github.com/projectdiscovery/nuclei-templates



# Katoolin
RUN cd ${HOME}/toolkit && \
    git clone https://github.com/LionSec/katoolin.git && \
    cd katoolin && \
    chmod +x katoolin.py

# cloudMist
RUN git clone https://github.com/m3chboy/cloudMist


# Clean Go Cache
RUN go clean -cache && \
    go clean -testcache && \
    go clean -modcache






    



