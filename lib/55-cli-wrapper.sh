#!/usr/bin/env bash
set -euo pipefail

step_cli_wrapper() {
  echo
  info "CLI Wrapper for FrankenPHP"

  local wrapper_name=""
  prompt wrapper_name "Enter the name for the CLI wrapper" "fphp"

  local wrapper_path="/usr/local/bin/${wrapper_name}"

  if [[ -f "$wrapper_path" ]]; then
    warn "Wrapper script already exists: $wrapper_path"
    if ! confirm "Overwrite it?"; then
       info "Skipping wrapper creation."
       return
    fi
  fi

  cat >"$wrapper_path" <<EOF
#!/usr/bin/env bash
exec ${FRANKENPHP_BIN} php-cli "\$@"
EOF

  chmod +x "$wrapper_path"

  info "Created executable wrapper: $wrapper_path"
  echo "  Example usage:"
  echo "    $wrapper_name -v"
  echo "    $wrapper_name artisan list"
  echo
}
