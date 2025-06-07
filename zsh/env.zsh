# Configuration
PROXY_PORT=12334
ENABLE_PROXY=false

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if a service is running on the specified port
check_service() {
    if netstat -tuln | grep -q ":$PROXY_PORT "; then
        return 0  # Service is running
    else
        return 1  # Service is not running
    fi
}

# Handle proxy setup
if [ "$ENABLE_PROXY" = true ]; then
    if check_service; then
        export http_proxy=http://localhost:$PROXY_PORT
        export https_proxy=http://localhost:$PROXY_PORT
    else
        if command_exists notify-send; then
            notify-send "VPN service is not running on port $PROXY_PORT. Proxy environment variables not set."
        else 
            echo "VPN service is not running on port $PROXY_PORT. Proxy environment variables not set."
        fi
    fi
fi
