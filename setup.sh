#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
LIB_DIR="${SCRIPT_DIR}/lib"

# shellcheck source=/dev/null
source "${LIB_DIR}/00-core.sh"
source "${LIB_DIR}/10-frankenphp-install.sh"
source "${LIB_DIR}/20-user.sh"
source "${LIB_DIR}/30-app.sh"
source "${LIB_DIR}/40-phpini.sh"
source "${LIB_DIR}/50-systemd.sh"
source "${LIB_DIR}/55-cli-wrapper.sh"
source "${LIB_DIR}/60-nginx.sh"
source "${LIB_DIR}/99-summary.sh"

main() {
  need_root

  echo
  info "Setup FrankenPHP Classic Mode"
  echo "--------------------------------------------"

  confirm_default_yes "Install FrankenPHP" && step_frankenphp_install
  confirm_default_yes "Configure Run User" && step_user
  confirm_default_yes "Configure Application" && step_app
  confirm_default_yes "Configure PHP settings" && step_phpini
  confirm_default_yes "Setup Systemd Service" && step_systemd
  confirm_default_yes "Create CLI Wrapper" && step_cli_wrapper
  confirm_default_yes "Configure Nginx" && step_nginx
  step_summary
}

main "$@"
