#!/usr/bin/env bash
set -euo pipefail

step_nginx() {
  echo
  info "Nginx integration (print-only mode)"
  echo
  info "This version does NOT search/replace or modify any nginx files."
  echo "It prints a ready-to-paste server block snippet."

  prompt DOMAIN "Server name (domain)" "example.com"
  prompt NGINX_ROOT "Nginx root (document root)" "$DOC_ROOT"
  prompt NGINX_BODY "client_max_body_size" "120m"

  local port="${LISTEN_ADDR##*:}"

  cat <<EOF

# -----------------------------
# Nginx snippet for ${DOMAIN}
# Paste into: /etc/nginx/sites-available/${DOMAIN}
# Then: ln -s to sites-enabled, nginx -t, reload
# -----------------------------

# Required for WebSocket/Upgrade support (put in /etc/nginx/conf.d/connection_upgrade_map.conf)
map \$http_upgrade \$connection_upgrade {
    default upgrade;
    ''      close;
}

server {
    listen 80;
    server_name ${DOMAIN};

    root ${NGINX_ROOT};
    index index.php index.html;

    client_max_body_size ${NGINX_BODY};

    location / {
        try_files \$uri @frankenphp;
    }

    location @frankenphp {
        proxy_http_version 1.1;
        proxy_set_header Host              \$host;
        proxy_set_header X-Real-IP         \$remote_addr;
        proxy_set_header X-Forwarded-For   \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection \$connection_upgrade;

        proxy_pass http://127.0.0.1:${port};
    }
}
EOF
}
