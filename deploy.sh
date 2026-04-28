#!/bin/bash
# Deploy script: updates deployment timestamp and pushes to GitHub Pages
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
sed -i "s/data-ts=\"[^\"]*\"/data-ts=\"$TIMESTAMP\"/" index.html
git add index.html
git commit -m "deploy: $TIMESTAMP"
git -c http.sslVerify=false push origin main
echo "Deployed at $TIMESTAMP"
