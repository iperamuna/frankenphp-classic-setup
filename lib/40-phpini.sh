#!/usr/bin/env bash
set -euo pipefail

step_phpini() {
  echo
  info "PHP settings (FrankenPHP)"

  ensure_dir "$PHP_CONF_DIR"

  if [[ ! -f "$PHP_OVERRIDES_FILE" ]]; then
    cat >"$PHP_OVERRIDES_FILE" <<'EOF'
; ===== FrankenPHP overrides (classic mode) =====
upload_max_filesize = 100M
post_max_size = 120M
memory_limit = 512M
max_execution_time = 120
max_input_time = 120
max_file_uploads = 50

; Opcache (recommended)
opcache.enable=1
opcache.enable_cli=1
opcache.memory_consumption=256
opcache.interned_strings_buffer=16
opcache.max_accelerated_files=20000
opcache.validate_timestamps=1
EOF
    info "Created: $PHP_OVERRIDES_FILE"
  else
    info "Exists: $PHP_OVERRIDES_FILE"
  fi

  open_editor "$PHP_OVERRIDES_FILE"
}
