# ssr-with-net-speeder

FROM centos:latest

MAINTAINER Lixd1985

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-* && \
    yum clean all && \
    yum makecache && \
    yum -y update && \
    yum -y install epel-release && \
    yum -y install python-pip && \
    yum -y install libnet libpcap libnet-devel libpcap-devel gcc git && \
    yum clean all && \
    pip install shadowsocks

RUN git clone https://github.com/snooda/net-speeder.git net-speeder
WORKDIR net-speeder
RUN sh build.sh

RUN mv net_speeder /usr/local/bin/
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/net_speeder

    
# Configure container to run as an executable 
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
