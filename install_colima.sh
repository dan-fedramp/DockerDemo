#!/usr/bin/env bash
set -euo pipefail

echo "==> Ensuring required packages are installed via Homebrew..."
if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is not installed. Please install Homebrew first: https://brew.sh"
  exit 1
fi

brew install colima docker docker-compose docker-buildx

echo "==> Starting Colima with Docker runtime..."
colima start --runtime docker

echo "==> Exporting Zscaler certificates from macOS keychain to ~/zscaler.pem..."
security find-certificate -a -c "Zscaler" -p > "$HOME/zscaler.pem"

echo "==> Ensuring CA tools are present in the Colima VM..."
colima ssh -- sudo apt-get update -y && colima ssh -- sudo apt-get install -y ca-certificates

USERNAME="$(whoami)"
CERT_SRC="/Users/${USERNAME}/zscaler.pem"
CERT_DST="/usr/local/share/ca-certificates/zscaler.crt"

if [[ ! -f "$CERT_SRC" ]]; then
  echo "Could not find $CERT_SRC. Make sure the export step succeeded."
  exit 1
fi

echo "==> Installing Zscaler cert into the Colima VM trust store..."
colima ssh -- sudo install -m 0644 "$CERT_SRC" "$CERT_DST"
colima ssh -- sudo update-ca-certificates

echo "==> Restarting the Colima VM..."
colima restart

echo "==> All done. Test with: docker run hello-world"
docker run hello-world