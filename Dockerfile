# 适用于NAT VPS的Xray Docker Image
# 选取基础镜像
FROM alpine:edge
# 拷贝配置文件
RUN mkdir /heroku
ADD etc/Caddyfile /heroku/Caddyfile
ADD etc/xray.json /heroku/xray.json
ADD start.sh /start.sh
# 执行构建命令
RUN apk update && \
    apk add --no-cache ca-certificates caddy  wget && \
    wget -O Xray-linux-64.zip  https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip  && \
    unzip Xray-linux-64.zip && \
    chmod +x /xray && \
    rm -rf /var/cache/apk/*  && \
    rm Xray-linux-64.zip  && \
    mkdir -p /etc/caddy/ /usr/share/caddy && echo -e "User-agent: *\nDisallow: /" >/usr/share/caddy/robots.txt  && \
    wget $CADDYIndexPage -O /usr/share/caddy/index.html && unzip -qo /usr/share/caddy/index.html -d /usr/share/caddy/ && mv /usr/share/caddy/*/* /usr/share/caddy/  && \
    chmod +x /start.sh  && \
    rm -rf /tmp/* 
# 添加启动脚本
CMD /start.sh
