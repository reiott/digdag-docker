FROM openjdk:8u212-jre-alpine
LABEL maintainer "nhn-comico"

WORKDIR /www

RUN apk add --no-cache \
      bash \
      curl \
      g++ \
      gcc \
      git \
      glib-dev \
      make \
      openssh \
      py3-pip \
      python3 \
      python3-dev \
      ruby \
      ruby-bundler \
      ruby-dev \
      ruby-json && \
    pip3 install --upgrade pip && \
    pip3 install python-dateutil && \
    curl -o /usr/local/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-latest" && \
    chmod +x /usr/local/bin/digdag && \
    sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd && \
    echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bash_profile >> ~/.bashrc

COPY ./digdag.properties /etc/digdag.properties
COPY ./entrypoint.sh /

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]