FROM ewpratten/echolink-base
ARG AMPR_ADDR
ARG NODE_NUM

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