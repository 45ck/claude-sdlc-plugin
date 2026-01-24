#!/usr/bin/env bash
#
# check-pnpm.sh - Check for pnpm installation
#
# This script verifies that pnpm is installed and provides installation
# instructions if it's not found. It runs at session start to ensure
# developers have the required package manager.
#
# Usage: Called automatically by SessionStart hook
# Exit: Always 0 (non-blocking warning)

set -euo pipefail

# Check if pnpm is installed
if command -v pnpm &> /dev/null; then
  PNPM_VERSION=$(pnpm --version 2>/dev/null || echo "unknown")
  echo "✓ pnpm is installed (version: $PNPM_VERSION)"
  exit 0
fi

# pnpm not found, provide installation instructions
cat << 'EOF'

⚠ Warning: pnpm is not installed

This project uses pnpm as its package manager. Please install it using one of the following methods:

  macOS/Linux:
    curl -fsSL https://get.pnpm.io/install.sh | sh -

  Windows (PowerShell):
    iwr https://get.pnpm.io/install.ps1 -useb | iex

  Using npm:
    npm install -g pnpm

  Using Homebrew (macOS):
    brew install pnpm

  Using Scoop (Windows):
    scoop install pnpm

For more information, visit: https://pnpm.io/installation

EOF

# Exit 0 (non-blocking warning)
exit 0
