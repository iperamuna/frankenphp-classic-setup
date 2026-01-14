#!/usr/bin/env bash
set -euo pipefail

step_frankenphp_install() {
  local default_fp=""
  local arch
  arch="$(uname -m)"

  # Check for custom build in frankenphp/
  if [[ "$arch" == "x86_64" && -f "${SCRIPT_DIR}/frankenphp/frankenphp-linux-x86_64" ]]; then
     info "Detected x86_64 architecture and custom build in 'frankenphp/'."
     default_fp="${SCRIPT_DIR}/frankenphp/frankenphp-linux-x86_64"
  elif [[ -x "./frankenphp" ]]; then
    default_fp="$(pwd)/frankenphp"
  elif has_cmd frankenphp; then
    default_fp="$(command -v frankenphp)"
  fi

  prompt FRANKENPHP_BIN "Destination path for FrankenPHP binary" "$FRANKENPHP_BIN"

  prompt FRANKENPHP_SRC "Source FrankenPHP executable path" "$default_fp"
  [[ -f "$FRANKENPHP_SRC" ]] || die "File not found: $FRANKENPHP_SRC"
  [[ -x "$FRANKENPHP_SRC" ]] || warn "Not executable; will chmod +x"

  info "Installing FrankenPHP to ${FRANKENPHP_BIN}..."
  cp -a "$FRANKENPHP_SRC" "$FRANKENPHP_BIN"
  chmod +x "$FRANKENPHP_BIN"

  if "$FRANKENPHP_BIN" version >/dev/null 2>&1; then
    info "FrankenPHP version:"
    "$FRANKENPHP_BIN" version || true
  else
    warn "Could not run '${FRANKENPHP_BIN} version' (binary may still work)."
  fi
}
