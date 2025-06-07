function __wait_and_notify_send_notification
    set -l pid $argv[1]
    set -l process_name $argv[2]
    set -l total_min $argv[3]
    set -l total_sec $argv[4]
    
    # Check if GOTIFY_TOKEN is set
    if test -z "$GOTIFY_TOKEN"
        echo "❌ Error: GOTIFY_TOKEN environment variable is not set"
        return 1
    end
    
    # Send notification
    set -l notification_title "Process Completed"
    set -l notification_message "Process '$process_name' (PID: $pid) has finished after $total_min:$(printf '%02d' $total_sec)"
    
    curl "https://notification.lumeny.io/message?token=$GOTIFY_TOKEN" \
         -F "title=$notification_title" \
         -F "message=$notification_message" \
         -F "priority=5" 2>/dev/null
    
    if test $status -eq 0
        echo "📲 Notification sent successfully!"
    else
        echo "❌ Failed to send notification"
        return 1
    end
end

function wait_then_notify
    set selected_process (ps -eo pid,cmd --no-headers | fzf)
    if test -z "$selected_process"
        echo "No process selected."
        return 1
    end
    
    set pid (echo $selected_process | awk '{print $1}')
    
    # Validate PID is a number
    if not string match -qr '^\d+$' $pid
        echo "❌ Error: Invalid PID extracted: '$pid'"
        echo "Debug: Full process line: '$selected_process'"
        return 1
    end
    
    # Check if process exists
    if not kill -0 $pid 2>/dev/null
        echo "❌ Error: Process with PID $pid does not exist or is not accessible"
        return 1
    end
    
    set process_name (echo $selected_process | awk '{$1=""; print $0}' | string trim)
    
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🎯 Selected process:"
    echo "   PID: $pid"
    echo "   Command: $process_name"
    echo "📲 Will send notification when process finishes"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    
    set seconds 0
    while kill -0 $pid 2>/dev/null
        sleep 1
        set seconds (math $seconds + 1)
        
        # Use integer division to get whole numbers
        set min (math --scale=0 "$seconds / 60")
        set sec (math --scale=0 "$seconds - $min * 60")
        
        printf "\r⏳ Waiting... %d:%02d" $min $sec
    end
    
    # Calculate total time
    set total_min (math --scale=0 "$seconds / 60")
    set total_sec (math --scale=0 "$seconds - $total_min * 60")
    
    printf "\n\n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
    printf "✅ Process finished! Sending notification...\n"
    printf "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n"
    
    # Send notification using helper function
    __wait_and_notify_send_notification $pid "$process_name" $total_min $total_sec
end
