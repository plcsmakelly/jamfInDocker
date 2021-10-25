FROM ubuntu:20.04

RUN apt-get install wget curl openjdk-11-jdk mysql-client unzip -y
COPY start.sh /start.sh
COPY jamfpro.zip /root/jamfpro.zip
RUN unzip /root/jamfpro.zip
RUN yes | /jamfproinstaller.run; exit 0
RUN mkdir /usr/local/jss/bin
COPY jamf-pro /usr/local/jss/bin/jamf-pro

EXPOSE 8443

ENTRYPOINT ["/start.sh"]
