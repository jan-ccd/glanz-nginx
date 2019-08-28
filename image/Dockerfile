FROM dostolu/nginx-ssl-proxy

ADD run.sh /usr/local/bin
RUN chmod +x /usr/local/bin/run.sh
RUN apt-get update || true
RUN apt-get install vim --assume-yes
RUN apt-get install curl --assume-yes
COPY ./nginx-ready.conf /etc/nginx/conf.d/proxy.conf
COPY ./.htpasswd-workers /etc/nginx/conf.d/.htpasswd-workers
COPY ./.htpasswd-admin /etc/nginx/conf.d/.htpasswd-admin

ENTRYPOINT ["run.sh"]

