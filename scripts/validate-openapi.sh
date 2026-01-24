#!/usr/bin/env bash
#
# validate-openapi.sh - Validate OpenAPI specifications before writing
#
# This script checks if a file being written is an OpenAPI specification
# and validates it against the OpenAPI schema. If validation fails, it
# blocks the write operation.
#
# Usage: Called automatically by PreToolUse hook
# Input: JSON from stdin containing tool_input with file_path and content
# Exit: 0 if valid or not an OpenAPI file, 2 if invalid (blocking)

set -euo pipefail

# Read JSON from stdin
JSON_INPUT=$(cat)

# Extract file_path from tool_input
FILE_PATH=$(echo "$JSON_INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"\([^"]*\)".*/\1/' || echo "")

# Exit if no file_path found
if [[ -z "$FILE_PATH" ]]; then
  exit 0
fi

# Check if this is likely an OpenAPI spec file
FILE_NAME=$(basename "$FILE_PATH")
if [[ ! "$FILE_NAME" =~ openapi|swagger ]]; then
  # Not an OpenAPI file, skip validation
  exit 0
fi

# Check file extension
FILE_EXT="${FILE_PATH##*.}"
if [[ ! "$FILE_EXT" =~ ^(json|yaml|yml)$ ]]; then
  # Not a JSON/YAML file, skip validation
  exit 0
fi

# Extract content from JSON input if this is a Write operation
CONTENT=""
if echo "$JSON_INPUT" | grep -q '"content"'; then
  # This is a Write operation, extract content
  # Note: This is a simplified extraction; proper JSON parsing would be better
  CONTENT=$(echo "$JSON_INPUT" | sed -n 's/.*"content"[[:space:]]*:[[:space:]]*"\(.*\)".*/\1/p')
fi

# If file exists, use it for validation; otherwise use extracted content
VALIDATE_FILE="$FILE_PATH"
TEMP_FILE=""

if [[ ! -f "$FILE_PATH" ]] && [[ -n "$CONTENT" ]]; then
  # Create temporary file with content for validation
  TEMP_FILE=$(mktemp)
  echo "$CONTENT" > "$TEMP_FILE"
  VALIDATE_FILE="$TEMP_FILE"
elif [[ ! -f "$FILE_PATH" ]]; then
  # File doesn't exist and no content, skip validation
  exit 0
fi

# Function to cleanup temp file
cleanup() {
  if [[ -n "$TEMP_FILE" ]] && [[ -f "$TEMP_FILE" ]]; then
    rm -f "$TEMP_FILE"
  fi
}
trap cleanup EXIT

# Check if validation tools are available
VALIDATOR=""
if command -v openapi-validator &> /dev/null; then
  VALIDATOR="openapi-validator"
elif command -v swagger-cli &> /dev/null; then
  VALIDATOR="swagger-cli"
elif command -v pnpm &> /dev/null; then
  # Try to use swagger-cli via pnpm
  if pnpm exec swagger-cli validate --help &> /dev/null 2>&1; then
    VALIDATOR="pnpm-swagger"
  fi
elif command -v npx &> /dev/null; then
  VALIDATOR="npx-swagger"
fi

# If no validator available, perform basic structure check
if [[ -z "$VALIDATOR" ]]; then
  # Basic validation: check for openapi or swagger field
  if [[ "$FILE_EXT" == "json" ]]; then
    if ! grep -q '"openapi"\|"swagger"' "$VALIDATE_FILE" 2>/dev/null; then
      echo "⚠ Warning: File appears to be OpenAPI spec but missing version field"
      echo "   Install swagger-cli for full validation: npm install -g @apidevtools/swagger-cli"
      exit 0  # Non-blocking warning
    fi
  elif [[ "$FILE_EXT" =~ ^(yaml|yml)$ ]]; then
    if ! grep -q '^openapi:\|^swagger:' "$VALIDATE_FILE" 2>/dev/null; then
      echo "⚠ Warning: File appears to be OpenAPI spec but missing version field"
      echo "   Install swagger-cli for full validation: npm install -g @apidevtools/swagger-cli"
      exit 0  # Non-blocking warning
    fi
  fi
  exit 0
fi

# Run validation based on available tool
case "$VALIDATOR" in
  openapi-validator)
    if ! openapi-validator "$VALIDATE_FILE" &> /dev/null; then
      echo "✗ OpenAPI validation failed: $FILE_PATH"
      echo "  Run 'openapi-validator $FILE_PATH' for details"
      exit 2  # Blocking error
    fi
    ;;
  swagger-cli)
    if ! swagger-cli validate "$VALIDATE_FILE" &> /dev/null; then
      echo "✗ OpenAPI validation failed: $FILE_PATH"
      echo "  Run 'swagger-cli validate $FILE_PATH' for details"
      exit 2  # Blocking error
    fi
    ;;
  pnpm-swagger)
    if ! pnpm exec swagger-cli validate "$VALIDATE_FILE" &> /dev/null; then
      echo "✗ OpenAPI validation failed: $FILE_PATH"
      echo "  Run 'pnpm exec swagger-cli validate $FILE_PATH' for details"
      exit 2  # Blocking error
    fi
    ;;
  npx-swagger)
    if ! npx --yes @apidevtools/swagger-cli validate "$VALIDATE_FILE" &> /dev/null 2>&1; then
      echo "✗ OpenAPI validation failed: $FILE_PATH"
      echo "  Run 'npx @apidevtools/swagger-cli validate $FILE_PATH' for details"
      exit 2  # Blocking error
    fi
    ;;
esac

echo "✓ OpenAPI validation passed: $FILE_PATH"
exit 0
