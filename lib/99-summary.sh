#!/usr/bin/env bash
set -euo pipefail

step_summary() {
  echo
  info "Done."
  echo "--------------------------------------------"
  echo "App Type:       ${APP_TYPE}"
  echo "App Dir:        ${APP_DIR}"
  echo "Doc Root:       ${DOC_ROOT}"
  echo "Listen:         ${LISTEN_ADDR}"
  echo "Service:        ${SERVICE_NAME}"
  echo "PHP overrides:  ${PHP_OVERRIDES_FILE}"
  echo
  echo "Tip: Laravel artisan with FrankenPHP:"
  echo "  /usr/local/bin/frankenphp php-cli artisan list"
  echo
}
