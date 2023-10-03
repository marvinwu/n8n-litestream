FROM n8nio/n8n:1.1.1 
USER root
RUN apk add --update python3 py3-pip
ADD https://github.com/benbjohnson/litestream/releases/download/v0.3.8/litestream-v0.3.8-linux-amd64-static.tar.gz /tmp/litestream.tar.gz
RUN tar -C /usr/local/bin -xzf /tmp/litestream.tar.gz
RUN apk add --no-cache qpdf
RUN apk add bash
RUN apk add ffmpeg
# rest of the things
COPY etc/litestream.yml /etc/litestream.yml
RUN mkdir -p /scripts
RUN pip install trafilatura 
RUN pip install --upgrade --force-reinstall "git+https://github.com/ytdl-org/youtube-dl.git"
RUN apk add --update bash && rm -rf /var/cache/apk/*
COPY scripts/run.sh /scripts/run.sh
RUN chown node:node /scripts
USER node
ENTRYPOINT ["tini", "--", "/scripts/run.sh"]
