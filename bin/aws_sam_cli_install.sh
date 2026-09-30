#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
os_name="$(uname -s)"

if [[ "${os_name}" == "Darwin" ]]; then
	if ! command -v brew >/dev/null 2>&1; then
		echo "Homebrew is required to install AWS SAM CLI on macOS." >&2
		exit 1
	fi

	if brew list aws-sam-cli >/dev/null 2>&1; then
		brew upgrade aws-sam-cli
	else
		brew install aws-sam-cli
	fi

	exit 0
fi

if [[ "${os_name}" != "Linux" ]]; then
	echo "Unsupported OS: ${os_name}" >&2
	exit 1
fi

cd "${root_dir}"
rm -rf sam-installation samcli.zip
curl -L "https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip" -o "samcli.zip"
unzip -oq samcli.zip -d sam-installation
sudo ./sam-installation/install