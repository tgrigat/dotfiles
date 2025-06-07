#!/bin/bash

while true; do
	if command -v nvim &>/dev/null; then
		nvim "$@"
		exit_status=$?
	elif command -v vim &>/dev/null; then
		vim "$@"
		exit_status=$?
	else
		echo "No suitable editor found. Please install lvim, nvim, or vim."
		exit 1
	fi

	if [ $exit_status -ne 1 ]; then
		break
	fi
done
