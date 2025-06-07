function tide_auto_os
    switch (uname)
        case Darwin
            echo '' # Apple icon
        case Linux
            # Check for specific Linux distributions
            if test -f /etc/os-release
                set -l os_id (awk -F= '/^ID=/{print $2}' /etc/os-release | tr -d '"')
                switch $os_id
                    case ubuntu
                        echo '' # Ubuntu icon
                    case debian
                        echo '' # Debian icon
                    case arch
                        echo '' # Arch icon
                    case alpine
                        echo "" # Alpine icon
                    case raspbian
                        echo '' # Raspbian icon
                    case '*'
                        echo '' # Generic Linux icon
                end
            else
                echo '' # Generic Linux icon
            end
        case '*'
            echo '?' # Generic OS icon
    end
end

set -x tide_os_icon (tide_auto_os)
