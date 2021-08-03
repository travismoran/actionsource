FROM ubuntu:16.04

COPY s3cmd-2.0.1.tar.gz /root
COPY supervisord.conf /etc/supervisor/conf.d/ahl2.conf

RUN dpkg --add-architecture i386
RUN apt -y update && apt -y install supervisor wget curl lib32gcc1 build-essential python-setuptools libc6:i386 libstdc++6:i386

RUN cd /root \
    && tar zxvf s3cmd-2.0.1.tar.gz \
    && cd s3cmd-2.0.1 \
    && python setup.py install

RUN mkdir /root/steam -p
COPY steamcmd_linux.tar.gz /root/steam

RUN cd /root/steam/ \
    && tar zxvf steamcmd_linux.tar.gz \
    && chmod +x steamcmd.sh \
    && ./steamcmd.sh +login anonymous +force_install_dir ~/sourcesdk2k13 +app_update 244310 +quit 

RUN cd /root/steam/ && ./steamcmd.sh +login anonymous +force_install_dir ~/sourcesdk2k13 +app_update 244310 +quit; exit 0 

RUN cd /root/steam/ && ./steamcmd.sh +login anonymous +force_install_dir ~/sourcesdk2k13 +app_update 244310 +quit; exit 0
    
#COPY config/server.cfg /root/sourcesdk2k13/action
#COPY config/mapcycle.txt /root/sourcesdk2k13/action
COPY bin/ /root/sourcesdk2k13/bin
COPY ahl2/ /root/sourcesdk2k13/ahl2/
COPY config/ahl2_start.sh /root/sourcesdk2k13/ahl2_start.sh

RUN chmod +x /root/sourcesdk2k13/ahl2_start.sh

CMD ["/usr/bin/supervisord", "-n"]
