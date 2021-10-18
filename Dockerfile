FROM alpine:latest
ARG AMPR_ADDR
ARG NODE_NUM

# Load everything needed for wireguard
RUN apk update
RUN apk add wireguard-tools
RUN apk add iptables
RUN apk add ip6tables

# Load Java
RUN apk add openjdk8

# Load webserver
# RUN apk add openrc
RUN apk add lighttpd
# RUN rc-update add lighttpd default
RUN sed -i -r 's#\#.*server.port.*=.*#server.port          = 80#g' /etc/lighttpd/lighttpd.conf
RUN sed -i -r 's#\#.*server.bind.*=.*#server.bind          = "0.0.0.0"#g' /etc/lighttpd/lighttpd.conf

COPY ./entrypoint.sh /entrypoint.sh
COPY ./ELProxy.conf /ELProxy.conf
COPY ./index.html /var/www/localhost/htdocs/index.html
COPY ./EchoLinkProxy.jar //EchoLinkProxy.jar

# Find & Replace the ELProxy config data
RUN sed -i "s/@@AMPR_ADDR@@/$AMPR_ADDR/g" /ELProxy.conf
RUN sed -i "s/@@NODE_NUM@@/$NODE_NUM/g" /ELProxy.conf
RUN sed -i "s/@@AMPR_ADDR@@/$AMPR_ADDR/g" /var/www/localhost/htdocs/index.html
RUN sed -i "s/@@NODE_NUM@@/$NODE_NUM/g" /var/www/localhost/htdocs/index.html
RUN echo "ELProxy.conf:"
RUN cat /ELProxy.conf

ENTRYPOINT [ "/entrypoint.sh" ]