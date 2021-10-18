FROM alpine:latest

# Load everything needed for wireguard
RUN apk update
RUN apk add wireguard-tools
RUN apk add iptables
RUN apk add ip6tables

# Load Java
RUN apk add openjdk8

# Load webserver
RUN apk add lighttpd
RUN sed -i -r 's#\#.*server.port.*=.*#server.port          = 80#g' /etc/lighttpd/lighttpd.conf
RUN sed -i -r 's#\#.*server.bind.*=.*#server.bind          = "0.0.0.0"#g' /etc/lighttpd/lighttpd.conf