FROM python:3.8.16-slim-bullseye

MAINTAINER marcel@marquez.fr

ARG branch_name=master

RUN apt-get update && apt-get -y install cron wget unzip python3-pip python3-pyqt5 curl libssl-dev libcurl4-openssl-dev
RUN wget https://tinfoil.io/repo/nut.src.latest.zip && \
    unzip nut.src.latest.zip -d /root && \
    cd /root/nut.src.latest && \
    curl https://raw.githubusercontent.com/blawar/nut/master/requirements.txt -o /root/nut.src.latest/requirements.txt && \
    pip3 install --requirement /root/nut.src.latest/requirements.txt

COPY /entrypoint.sh /
COPY conf /root/nut.src.latest/conf

RUN chmod +x /entrypoint.sh

RUN touch /var/log/cron.log && touch /var/log/nut.log

EXPOSE 9000

ENTRYPOINT ["sh", "/entrypoint.sh"]

