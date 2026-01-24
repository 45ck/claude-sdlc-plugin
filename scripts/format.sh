#!/usr/bin/env bash
#
# format.sh - Auto-format files after Write/Edit operations
#
# This script runs prettier on supported file types to maintain consistent
# code formatting across the project. It's non-blocking and will gracefully
# handle cases where prettier is not installed.
#
# Usage: Called automatically by PostToolUse hook
# Input: JSON from stdin containing tool_input with file_path
# Exit: Always 0 (non-blocking)

set -euo pipefail

# Read JSON from stdin
JSON_INPUT=$(cat)

# Extract file_path from tool_input
FILE_PATH=$(echo "$JSON_INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"\([^"]*\)".*/\1/' || echo "")

# Exit if no file_path found
if [[ -z "$FILE_PATH" ]]; then
  exit 0
fi

# Check if file exists
if [[ ! -f "$FILE_PATH" ]]; then
  exit 0
fi

# Get file extension
FILE_EXT="${FILE_PATH##*.}"

# Check if file type is supported for formatting
case "$FILE_EXT" in
  js|ts|jsx|tsx|json|md|mdx|yaml|yml)
    # Check if prettier is installed
    if command -v prettier &> /dev/null; then
      # Run prettier on the file
      if prettier --write "$FILE_PATH" &> /dev/null; then
        echo "✓ Formatted: $FILE_PATH"
      else
        echo "⚠ Could not format: $FILE_PATH (prettier failed)"
      fi
    elif command -v pnpm &> /dev/null; then
      # Try using pnpm prettier if available
      if pnpm exec prettier --write "$FILE_PATH" &> /dev/null; then
        echo "✓ Formatted: $FILE_PATH"
      else
        echo "⚠ Could not format: $FILE_PATH (prettier failed)"
      fi
    elif command -v npx &> /dev/null; then
      # Try using npx prettier as fallback
      if npx --yes prettier --write "$FILE_PATH" &> /dev/null 2>&1; then
        echo "✓ Formatted: $FILE_PATH"
      fi
    fi
    ;;
  *)
    # Unsupported file type, skip formatting
    ;;
esac

# Always exit 0 (non-blocking)
exit 0
