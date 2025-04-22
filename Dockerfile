FROM debian:12-slim

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install bash curl bzip2 ffmpeg cifs-utils alsa-utils libicu72

ENV ROON_SERVER_PKG RoonServer_linuxx64.tar.bz2
ENV ROON_DATAROOT /data
ENV ROON_ID_DIR /data

# 创建临时目录用于构建
RUN mkdir -p /tmp/roonserver
COPY RoonServer_linuxx64.tar.bz2 /tmp/roonserver/

# 解压到临时目录
RUN tar -xjf /tmp/roonserver/RoonServer_linuxx64.tar.bz2 -C /tmp/roonserver \
    && rm /tmp/roonserver/RoonServer_linuxx64.tar.bz2

# 复制启动脚本
COPY run.sh /run.sh
RUN sed -i 's/\r$//' /run.sh && chmod +x /run.sh

ENTRYPOINT ["/run.sh"]