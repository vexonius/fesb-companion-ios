#!/bin/sh

defaults write com.apple.dt.Xcode IDESkipMacroFingerprintValidation -bool YES

# Install dependencies
brew tap tuist/tuist
brew install --formula tuist
brew install gh

# GitHub repository details
REPO_OWNER="vexonius"
REPO_NAME="fesb-companion-shared"
REPO_FULL="$REPO_OWNER/$REPO_NAME"

gh release download --repo "$REPO_FULL" --pattern "*.zip"

for zip_file in *.zip; do
    if [ -f "$zip_file" ]; then
        echo "Extracting $zip_file"
        unzip -q "$zip_file" -d ../
        rm "$zip_file"  # Remove zip after extraction
    fi
done

tuist generate --no-open --path ..
