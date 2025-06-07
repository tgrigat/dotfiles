#!/bin/zsh

FILE_PATH="$1"
USER_INPUT="$2"

# Display the user input in a kdialog popup for 5 seconds
kdialog --passivepopup "File: $FILE_PATH, User input: $USER_INPUT" 5
