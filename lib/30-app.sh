#!/usr/bin/env bash
set -euo pipefail

detect_app_type() {
  local dir="$1"

  if [[ -f "$dir/artisan" && -d "$dir/bootstrap" ]]; then
    echo "laravel"
    return 0
  fi

  if [[ -f "$dir/wp-config.php" || -d "$dir/wp-admin" ]]; then
    echo "wordpress"
    return 0
  fi

  if [[ -f "$dir/index.php" ]]; then
    echo "vanilla"
    return 0
  fi

  echo "unknown"
}

step_app() {
  echo
  info "App setup"

  prompt APP_DIR "3) Project directory (Laravel root / WP root / vanilla root)" "/var/www/myapp"
  [[ -d "$APP_DIR" ]] || die "App dir not found: $APP_DIR"

  local detected
  detected="$(detect_app_type "$APP_DIR")"
  info "Detected app type: $detected"

  prompt APP_TYPE "Choose app type (laravel/wordpress/vanilla/unknown)" "$detected"

  local suggested_docroot="$APP_DIR"
  if [[ "$APP_TYPE" == "laravel" ]]; then
    suggested_docroot="$APP_DIR/public"
  fi

  prompt DOC_ROOT "Document root to serve (Nginx root + FrankenPHP --root)" "$suggested_docroot"
  [[ -d "$DOC_ROOT" ]] || die "DOC_ROOT not found: $DOC_ROOT"
  [[ -f "$DOC_ROOT/index.php" || -f "$DOC_ROOT/index.html" ]] || warn "No index.php/index.html in DOC_ROOT; verify your root."

  info "Setting ownership and writable dirs..."
  chown -R "$RUN_USER:$RUN_USER" "$APP_DIR"

  if [[ "$APP_TYPE" == "laravel" ]]; then
    chmod -R ug+rwX "$APP_DIR/storage" "$APP_DIR/bootstrap/cache" 2>/dev/null || true
  fi

  if [[ "$APP_TYPE" == "wordpress" ]]; then
    if [[ -d "$APP_DIR/wp-content" ]]; then
      chmod -R ug+rwX "$APP_DIR/wp-content" 2>/dev/null || true
    fi
  fi
}
