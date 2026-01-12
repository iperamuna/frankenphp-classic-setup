#!/usr/bin/env bash
set -euo pipefail

step_user() {
  prompt RUN_USER "2) Dedicated system user to run FrankenPHP" "frankenphp"

  if id "$RUN_USER" >/dev/null 2>&1; then
    info "User exists: $RUN_USER"
  else
    info "Creating system user: $RUN_USER"
    useradd --system --no-create-home --shell /usr/sbin/nologin "$RUN_USER"
  fi
}
