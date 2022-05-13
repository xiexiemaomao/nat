#!/bin/sh
# 修改配置文件
cat /heroku/Caddyfile  | sed -e "1c :$PORT" -e "s/\$AUUID/$AUUID/g" -e "s/\$MYUUID-HASH/$(caddy hash-password --plaintext $AUUID)/g" >/etc/caddy/Caddyfile 
cat /heroku/xray.json  | sed -e "s/\$AUUID/$AUUID/g" >/xray.json  
# 启动Xray
/xray -config /xray.json &
# 启动Caddy
caddy run --config /etc/caddy/Caddyfile --adapter caddyfile 
