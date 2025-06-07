function loop_command
    echo "Running command in a loop. Press Ctrl+C to stop."
    while true
        eval $argv
        echo "Command completed, restarting in 1 second..."
        sleep 1
    end
end
