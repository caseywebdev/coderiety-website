FROM nginx:1.13.3-alpine

ENV \
  CONSUL_TEMPLATE_VERSION='0.19.3' \
  CONTAINERPILOT_VERSION='3.4.2'

RUN \
  apk --no-cache add curl && \
  mkdir -p /run/nginx && \
  curl -fLsS https://releases.hashicorp.com/consul-template/$CONSUL_TEMPLATE_VERSION/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.tgz | \
    tar xz -C /usr/local/bin && \
  curl -fLsS https://github.com/joyent/containerpilot/releases/download/$CONTAINERPILOT_VERSION/containerpilot-$CONTAINERPILOT_VERSION.tar.gz | \
    tar xz -C /usr/local/bin

WORKDIR /code

COPY bin bin
COPY etc etc
COPY public public

ENV \
  CONSUL_SERVICE_NAME='coderiety-website' \
  CONSUL_SERVICE_TAGS='' \
  CONSUL_URL='' \
  CODERIETY_WEBSITE_URL='http://localhost' \
  CONTAINERPILOT='/code/etc/containerpilot.json5.gotmpl'

CMD ["containerpilot"]
