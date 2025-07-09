#!/bin/bash

# Use an Nginx proxy to force the Host and replace the links to allow most applciations
# to work with killercoda proxy for external access
echo "Configuring proxy for Killercoda external access..." >> ${LOG}

#Install nginx with substitution mode
apt install -y nginx libnginx-mod-http-subs-filter

#write nginx configuration
cat <<EOF >/etc/nginx/nginx.conf
user www-data;
worker_processes auto;
pid /run/nginx.pid;
error_log /var/log/nginx/error.log;
include /etc/nginx/modules-enabled/*.conf;

events {
  worker_connections 768;
  # multi_accept on;
}

http {
  access_log /dev/null;
  gzip on;
EOF

# All the proxy redirects must be placed into all the proxied sites, otherwise cross-site
# redirections like the ones done by OPA will not work...
echo -n "" > /tmp/assets/killercodaproxy_redirects
while read port dest types; do
  echo "         proxy_redirect http://$dest `sed -e "s/PORT/$port/g" /etc/killercoda/host`;" >> /tmp/assets/killercodaproxy_redirects
done < /tmp/assets/killercodaproxy

while read port dest types; do
    cat <<EOF >>/etc/nginx/nginx.conf
    server {
        listen  $port;
        location / {
            proxy_pass  http://$dest;
            proxy_set_header  Host  $dest:80;
            proxy_set_header Accept-Encoding "";
EOF

    cat /tmp/assets/killercodaproxy_redirects >> /etc/nginx/nginx.conf
    [[ "$types" != "NONE" && "$types" != "'NONE'" ]] && cat <<EOF >>/etc/nginx/nginx.conf
            subs_filter http://$dest  `sed -e "s/PORT/$port/g" /etc/killercoda/host`;
            subs_filter $dest  `sed -e "s/PORT/$port/g" -e "s|^https://||" /etc/killercoda/host`;
            subs_filter_types ${types//\'/};
EOF

cat <<EOF >>/etc/nginx/nginx.conf
        }
    }
EOF

done < /tmp/assets/hosts

echo "}" >> /etc/nginx/nginx.conf
  
# restart nginx
systemctl restart nginx
