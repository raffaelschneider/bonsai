#!/bin/sh

# Bonsai installation script

REPO_URL="https://github.com/raffaelschneider/bonsai.git"
INSTALL_DIR="$HOME/bonsai"

echo "Installing Bonsai setup tool..."

# Clone the repository
if [ -d "$INSTALL_DIR" ]; then
    echo "Directory $INSTALL_DIR already exists. Updating repository..."
    cd "$INSTALL_DIR" && git pull
else
    echo "Cloning repository..."
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# Make the main script executable
chmod +x "$INSTALL_DIR/bonsai.pl"

# Add bonsai to the PATH if not already there
if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
    echo "Adding Bonsai to PATH..."
    echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$HOME/.profile"
    export PATH="$PATH:$INSTALL_DIR"
fi

echo "Installation complete. Run bonsai with:"
echo "$INSTALL_DIR/bonsai.pl --help"

