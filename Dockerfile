FROM nginx:1.11.10

WORKDIR /code

COPY bin /code/bin
COPY etc /code/etc
COPY public /code/public

env SERVER_NAME www.dev.coderiety.com
env URL http://www.dev.coderiety.com

CMD ["bin/run"]
