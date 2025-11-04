#!/bin/bash

# Script to convert a webpage to PDF and email it to a Kindle device
# Requires: wkhtmltopdf, mailutils
# Usage: ./send_to_kindle.sh <url> [optional_custom_filename]
# Not in use anymore - Here for reference only
# Author: codetit4n (https://github.com/codetit4n)

URL="$1"
CUSTOM_NAME="$2"
EMAIL="Your Kindle Email Address Here"
DEST_FOLDER="$HOME/Downloads/kindle_pdfs"

# Validate URL input
if [ -z "$URL" ]; then
  echo "Usage: $0 <url> [optional_custom_filename]"
  exit 1
fi

# Ensure destination folder exists
mkdir -p "$DEST_FOLDER"

# Get local timestamp: e.g., 2025-06-30_18-40
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")

# Determine filename base (custom name or <title>)
if [ -z "$CUSTOM_NAME" ]; then
  PAGE_TITLE=$(curl -s "$URL" | grep -oP '(?<=<title>).*?(?=</title>)' | head -n 1)
  [ -z "$PAGE_TITLE" ] && PAGE_TITLE="webpage"
  SAFE_NAME=$(echo "$PAGE_TITLE" | tr -cd '[:alnum:]-_' | tr ' ' '_' | cut -c1-50)
else
  SAFE_NAME=$(echo "$CUSTOM_NAME" | tr -cd '[:alnum:]-_' | tr ' ' '_' | cut -c1-50)
fi

FILENAME="${TIMESTAMP}-${SAFE_NAME}.pdf"
FULL_PATH="$DEST_FOLDER/$FILENAME"

# Generate PDF
echo "📝 Generating PDF: \"$FULL_PATH\""
wkhtmltopdf "$URL" "$FULL_PATH"

if [ $? -ne 0 ]; then
  echo "❌ Failed to generate PDF"
  exit 2
fi

# Send to Kindle
echo "📤 Sending \"$FILENAME\" to Kindle ($EMAIL)..."
echo "Here is the PDF version of $URL" | mail -s "Kindle PDF: $FILENAME" -a "$FULL_PATH" "$EMAIL"

if [ $? -eq 0 ]; then
  echo "✅ Successfully sent \"$FILENAME\" to $EMAIL"
else
  echo "❌ Failed to send email"
  exit 3
fi
