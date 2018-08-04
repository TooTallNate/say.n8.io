FROM tootallnate/bashttpd:1.3.0

RUN apk add --no-cache python && \
  python -m ensurepip && \
  rm -r /usr/lib/python*/ensurepip && \
  pip install --upgrade pip setuptools && \
  pip install gTTS

COPY server.sh /etc/bashttpd/bashttpd.conf
USER nobody
