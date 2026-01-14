#!/usr/bin/env bash
set -euo pipefail

color() { printf "\033[%sm%s\033[0m" "$1" "$2"; }
info()  { echo "$(color 36 "[INFO]") $*"; }
warn()  { echo "$(color 33 "[WARN]") $*"; }
err()   { echo "$(color 31 "[ERR ]") $*" >&2; }
die()   { err "$*"; exit 1; }

need_root() {
  if [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
    die "Run as root: sudo $0"
  fi
}

has_cmd() { command -v "$1" >/dev/null 2>&1; }

prompt() {
  local var="$1" msg="$2" def="${3:-}"
  local input=""
  if [[ -n "$def" ]]; then
    read -r -p "$msg [$def]: " input
    input="${input:-$def}"
  else
    read -r -p "$msg: " input
  fi
  printf -v "$var" "%s" "$input"
}

confirm() {
  local msg="$1"
  local ans=""
  read -r -p "$msg [y/N]: " ans
  [[ "${ans,,}" == "y" || "${ans,,}" == "yes" ]]
}

confirm_default_yes() {
  local msg="$1"
  local ans=""
  read -r -p "$msg [Y/n]: " ans
  [[ -z "$ans" || "${ans,,}" == "y" || "${ans,,}" == "yes" ]]
}

ensure_dir() { mkdir -p "$1"; }

open_editor() {
  local file="$1"
  local editor="${EDITOR:-nano}"
  info "Opening in editor: $editor $file"
  $editor "$file"
}

backup_file() {
  local file="$1"
  local ts
  ts="$(date +%Y%m%d-%H%M%S)"
  cp -a "$file" "${file}.bak.${ts}"
  info "Backup created: ${file}.bak.${ts}"
}

# Global variables filled by steps
FRANKENPHP_BIN="/usr/local/bin/frankenphp"
RUN_USER=""
APP_TYPE=""
APP_DIR=""
DOC_ROOT=""
DOMAIN=""
LISTEN_ADDR="127.0.0.1:9000"
SERVICE_NAME=""
SERVICE_FILE=""
PHP_CONF_DIR="/etc/frankenphp/conf.d"
PHP_OVERRIDES_FILE="/etc/frankenphp/conf.d/99-overrides.ini"
