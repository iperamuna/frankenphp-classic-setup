#!/usr/bin/env bash
set -euo pipefail

step_systemd() {
  echo
  info "Systemd service"

  prompt LISTEN_ADDR "FrankenPHP listen address (loopback recommended)" "$LISTEN_ADDR"

  SERVICE_NAME="frankenphp-$(basename "$APP_DIR")"
  SERVICE_FILE="/etc/systemd/system/${SERVICE_NAME}.service"

  if [[ -f "$SERVICE_FILE" ]]; then
    warn "Service already exists: $SERVICE_FILE"
    if confirm "Open it for editing?"; then
      open_editor "$SERVICE_FILE"
    fi
  else
    cat >"$SERVICE_FILE" <<EOF
[Unit]
Description=FrankenPHP Classic for $(basename "$APP_DIR")
After=network.target

[Service]
User=${RUN_USER}
Group=${RUN_USER}
WorkingDirectory=${APP_DIR}

# FrankenPHP build compatibility: use scan dir instead of --php-ini
Environment=PHP_INI_SCAN_DIR=${PHP_CONF_DIR}

ExecStart=${FRANKENPHP_BIN} php-server \
  --listen ${LISTEN_ADDR} \
  --root ${DOC_ROOT}

Restart=always
RestartSec=2
LimitNOFILE=1048576

# Hardening (optional)
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=full
ProtectHome=true
EOF

    if [[ "$APP_TYPE" == "laravel" ]]; then
      cat >>"$SERVICE_FILE" <<EOF
ReadWritePaths=${APP_DIR}/storage ${APP_DIR}/bootstrap/cache
EOF
    fi

    if [[ "$APP_TYPE" == "wordpress" ]]; then
      cat >>"$SERVICE_FILE" <<EOF
ReadWritePaths=${APP_DIR}/wp-content
EOF
    fi

    cat >>"$SERVICE_FILE" <<'EOF'

[Install]
WantedBy=multi-user.target
EOF

    info "Created: $SERVICE_FILE"
    open_editor "$SERVICE_FILE"
  fi

  info "Reloading systemd and starting service..."
  systemctl daemon-reload
  systemctl enable --now "$SERVICE_NAME"
  systemctl status "$SERVICE_NAME" --no-pager || true
}
