FROM debian

MAINTAINER "Vitalie Maldur" <vitalie.maldur@eaudeweb.ro>

RUN apt-get update; apt-get -y install cron wget
ADD crontab /etc/cron.d/cronjobs

ADD start.sh /start.sh
RUN chmod -v +x /start.sh

CMD ["/start.sh"]
