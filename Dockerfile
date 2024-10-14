FROM python:3.11-alpine AS builder

RUN apk update && apk add  --no-cache tzdata alpine-sdk libffi-dev ca-certificates git
ADD requirements.txt /tmp/
RUN pip3 install --user -r /tmp/requirements.txt && rm /tmp/requirements.txt

# Clone and install yt-dlp-plugin-yellow
RUN git clone https://github.com/wmrussell8653/yt-dlp-plugin-yellow.git /tmp/yt-dlp-plugin-yellow

FROM python:3.11-alpine
WORKDIR /ytdlbot/ytdlbot
ENV TZ=Europe/Stockholm

COPY apk.txt /tmp/
RUN apk update && xargs apk add  < /tmp/apk.txt
COPY --from=builder /root/.local /usr/local
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /usr/share/zoneinfo /usr/share/zoneinfo
COPY . /ytdlbot

# Copy yt-dlp-plugin-yellow to the appropriate location
RUN mkdir -p /root/.config/yt-dlp/plugins
COPY --from=builder /tmp/yt-dlp-plugin-yellow /root/.config/yt-dlp/plugins/yt-dlp-plugin-yellow

CMD ["/usr/local/bin/supervisord", "-c" ,"/ytdlbot/conf/supervisor_main.conf"]
