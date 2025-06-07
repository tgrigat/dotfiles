function kill_other_ssh_sessions
    # Get the parent process ID (PPID) of the current Fish shell
    set -l ppid (ps -o ppid= -p $fish_pid | string trim)
    
    # Validate that the parent process is an sshd process
    set -l parent_process (ps -o comm= -p $ppid)
    if test "$parent_process" != "sshd"
        echo "Warning: The parent process is not an sshd process. Exiting."
        return 1
    end
    
    # Get the username associated with the current SSH session
    set -l username (whoami)
    
    # Get the current SSH session's process ID
        set -l current_ssh_pid $ppid
    
        # Find and kill all other SSH sessions for the same user, excluding the current one
        for pid in (ps -u $username -o pid=,comm= | awk '$2 == "sshd" {print $1}')
                if test $pid -ne $current_ssh_pid
                        echo "Killing SSH session with PID $pid"
                        kill -9 $pid
                end
        end
end
