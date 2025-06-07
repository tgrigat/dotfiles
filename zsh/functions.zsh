function add-pyrightconfig() {
     local config_content='{
      "reportImplicitOverride": "information",
      "reportUnknownParameterType": "information",
      "reportMissingParameterType": "information",
      "reportMissingTypeStubs": "information",
      "reportUnknownMemberType": false,
      "reportUnknownArgumentType": false,
      "reportArgumentType": "warning",
      "typeCheckingMode": "basic",
 }'
     if [[ ! -d .git ]]; then
         echo "Warning: Current directory is not a git repository root."
         read -q "REPLY?Do you really want to add pyrightconfig.json here? (y/N) "
         echo
         if [[ ! $REPLY =~ ^[Yy]$ ]]; then
             echo "Operation cancelled."
             return 1
         fi
     fi
     if [[ -f pyrightconfig.json ]]; then
         echo "pyrightconfig.json already exists in the current directory."
         echo "Here's the content we would have injected:"
         echo "$config_content"
     else
         echo "$config_content" > pyrightconfig.json
         echo "pyrightconfig.json has been created in the current directory."
     fi
 }

function create_py_dev_cfgs() {
    # Create pyrightconfig.json
    if [ ! -f pyrightconfig.json ]; then
        cat > pyrightconfig.json << EOF
{
  "typeCheckingMode": "basic",
  "pythonPlatform": "Linux",
  "reportMissingImports": false,
  "useLibraryCodeForTypes": true,
  "reportMissingTypeStubs": false,
  "reportGeneralTypeIssues": false,
  "reportPrivateImportUsage": "information",
  "exclude": ["pdb_history.py"],
  "ignore": ["pdb_history.py"]
}
EOF
    fi

    # Create .flake8
    if [ ! -f .flake8 ]; then
        cat > .flake8 << EOF
[flake8]
ignore = E501, E203, E402
exclude =
    pdb_history.py,
    # yet_another_file.py
EOF
    fi

    # Create .ruff.toml
    if [ ! -f .ruff.toml ]; then
        cat > .ruff.toml << EOF
[tool.ruff]
# Exclude a variety of commonly ignored directories.
exclude = [
    ".bzr",
    ".direnv",
    ".eggs",
    ".git",
    ".git-rewrite",
    ".hg",
    ".mypy_cache",
    ".nox",
    ".pants.d",
    ".pytype",
    ".ruff_cache",
    ".svn",
    ".tox",
    ".venv",
    "__pypackages__",
    "_build",
    "buck-out",
    "build",
    "dist",
    "node_modules",
    "venv",
    "pdb_history.py"
]

[tool.ruff.lint]
# Enable Pyflakes (F) and a subset of the pycodestyle (E)  codes by default.
# select = ["E4", "E7", "E9", "F"]
ignore = ["E266",]
EOF
    fi
}

function lvim_clearn_sessions() {
  rm ~/.local/share/lvim/sessions/*
  echo "Cleared sessions at ~/.local/share/lvim/sessions"
}

function gui() {
  if [[ $1 = "x" ]]; then
    # todo fix this
    export XDG_SESSION_TYPE=x11
    export XDG_SESSION_TYPE=xcb
    export DISPLAY=:1
    startplasma-x11
  else
    export XDG_SESSION_TYPE=wayland
    export QT_QPA_PLATFORM=wayland
    exec startplasma-wayland
  fi
}

function download_eget() {
	curl -o eget.sh https://zyedidia.github.io/eget.sh && \
	bash eget.sh && \
	mv eget ~/.local/bin
}

function rbt2win() {
    if [[ -f /usr/bin/grub-reboot ]]; then
        sudo grub-reboot "$(grep -i windows /boot/grub/grub.cfg|cut -d"'" -f2)" 
        sudo reboot
    else
        systemctl reboot --boot-loader-entry=auto-windows
    fi

}

function copy-pdf-to-ob() {
    if [ "$#" -ne 1 ]; then
        echo "Error: This function requires one argument only."
        return 1
    fi

    if [ ! -f "$1" ]; then
        echo "Error: The specified file does not exist."
        return 1
    fi

    if [[ "$1" != *.pdf ]]; then
        echo "Error: The file is not a PDF."
        return 1
    fi

    cp "$1" ~/obsidian/attachments/PDF
}

function run_autostart_apps() {
  autostart_dir="${HOME}/.config/autostart"
  
  if [ -d "${autostart_dir}" ]; then
    for desktop_file in "${autostart_dir}"/*.desktop; do
      if [ -f "${desktop_file}" ]; then
        xdg-open "${desktop_file}" >/dev/null 2>&1 &
      fi
    done
  else
    echo "Autostart directory not found: ${autostart_dir}"
  fi
}

function notify() {
  if [[ -z "$1" ]]; then
    echo "done" > ~/.notify
  else
    echo "$1" > ~/.notify
  fi
}

function run_background {
    $* >/dev/null 2>&1 &
}

# press S to quit vifm and move to pwd
function vfcd()
{
    local dst="$(command vifm --choose-dir - "$@")"
    if [ -z "$dst" ]; then
        echo 'Directory picking cancelled/failed'
        return 1
    fi
    cd "$dst"
}

# press Q to quit ranger and move to pwd
function ranger() {
    local IFS=$'\t\n'
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    local ranger_cmd=(
    command ranger --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
    )

    ${ranger_cmd[@]} "$@"
    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$PWD" ]]; then
        cd -- "$(cat "$tempfile")" || return
    fi
    command rm -f -- "$tempfile" 2>/dev/null
}

function mal {
	
	# Check if the user has provided a help option or no arguments
	if [[ "$1" = "-h" ]] || [[ "$1" = "--help" ]] || [[ "$1" = "-help" ]] || [[ $# -eq 0 ]]; then
		# Display usage information
		echo "Usage: mal [OPTION]... [ALIAS_NAME] [ALIAS_COMMAND]..."
		echo ""
		echo "Create, delete, change, or execute aliases interactively."
		echo ""
		echo "Options:"
		echo "  -h, --help       display this help and exit"
		echo "  -l               list all aliases in \$ALIASES_FILE"
		echo "  -e               execute an alias interactively"
		echo "  -d               delete an alias interactively"
		echo "  -dn NAME         delete an alias by name"
		echo "  -r               rename an alias interactively"
		echo "  -rn OLD NEW      rename an existing alias"
		echo "  -c               change the command associated with an existing alias interactively"
		echo "  -cc NAME COMMAND change the command associated with an existing alias by name"
		return 0
	fi

# Execute an alias interactively if the -e option is used
	if [[ $1 = "-e" ]]; then
		# Use fzf to allow the user to select an alias from the aliases file
		local alias_to_execute=$(cut -d' ' -f2- $ALIASES_FILE | fzf)
		# Check if the user cancelled the selection
		if [[ -z $alias_to_execute ]]; then
			return 1
		fi
		echo Executing alias: $alias_to_execute
		# Execute the selected alias
		eval ${alias_to_execute%%=*}
		return 0

	# List all aliases if the -l option is used
	elif [[ $1 = -l ]]; then
		# List all aliases in $ALIASES_FILE
		cut -d' ' -f2- $ALIASES_FILE | cat

	# Delete an alias interactively if the -d option is used
	elif [[ $1 = -d ]]; then
		# Use fzf to allow the user to select an alias from the aliases file
		local alias_to_delete=$(cut -d' ' -f2- $ALIASES_FILE | fzf)
		# Check if the user cancelled the selection
		if [[ -z $alias_to_delete ]]; then
			return 1
		fi
		echo Deleted alias: $alias_to_delete
		# Delete the selected alias from the aliases file
		sed -i "/^alias ${alias_to_delete%%=*}=/d" $ALIASES_FILE
		unalias ${alias_to_delete%%=*}

	# Delete an alias by name if the -dn option is used
	elif [[ $1 = -dn ]]; then
		local alias_to_delete=$2
		local line_with_alias=$(grep "$2=" $ALIASES_FILE)
		# Check if the alias exists in the aliases file
		if [[ -z "$line_with_alias" ]]; then
			echo No alias with the name $2 found.
			return 2
		fi
		echo Deleted alias: $alias_to_delete
		# Delete the selected alias from the aliases file
		sed -i "/^alias ${alias_to_delete%%=*}=/d" $ALIASES_FILE
		unalias ${alias_to_delete%%=*}

  # rename an alias interactively
  elif [[ $1 = "-r" ]]; then
    # Rename an existing alias by selecting it from a list
    local alias_to_rename=$(cut -d' ' -f2- $ALIASES_FILE | fzf)
    # Check if the user cancelled the selection
    if [[ -z $alias_to_rename ]]; then
      return 1
    fi

    echo "Input new name:"
    read new_name
    echo "Renaming alias from $alias_to_rename to $new_name"
    sed -i "s/^alias ${alias_to_rename%%=*}=/alias ${new_name}=/g" $ALIASES_FILE
    unalias ${alias_to_rename%%=*}

  elif [[ $1 = "-rn" ]]; then
    # Rename an existing alias using specified old and new names
    if [[ -z "$2" || -z "$3" ]]; then
      echo "Usage: mal -r OLD_ALIAS_NAME NEW_ALIAS_NAME"
      return 1
    fi

    local old_alias_name=$2
    local new_alias_name=$3
    local line_with_alias=$(grep "^alias ${old_alias_name}=" $ALIASES_FILE)

    if [[ -z "$line_with_alias" ]]; then
      echo "No alias with the name $old_alias_name found."
      return 1
    fi

    echo "Renaming alias from $old_alias_name to $new_alias_name"
    sed -i "s/^alias ${old_alias_name}=/alias ${new_alias_name}=/g" $ALIASES_FILE
    unalias ${old_alias_name}

  elif [[ $1 = "-c" ]]; then
    # Change the command associated with an existing alias by selecting it from a list
    local alias_to_change=$(cut -d' ' -f2- $ALIASES_FILE | fzf)
    # Check if the user cancelled the selection
    if [[ -z $alias_to_change ]]; then
      return 1
    fi

    echo "Input new command:"
    read new_command
    echo "Changing command for alias ${alias_to_change%%=*} to \"$new_command\""
    sed -i "/^alias ${alias_to_change%%=*}=/{s/=.*/=\"$new_command\"/}" $ALIASES_FILE

  elif [[ $1 = "-cc" ]]; then
    # Change the command associated with an existing alias using specified name and command
    local alias_to_change=$2
    local new_command="${@:3}"
    local line_with_alias=$(grep "$alias_to_change=" $ALIASES_FILE)

    if [[ -z "$line_with_alias" ]]; then
      echo "No alias with the name $alias_to_change found."
      return 1
    fi

    echo "Changing command for alias $alias_to_change to \"$new_command\""
    sed -i "/^alias ${alias_to_change}=/{s/=.*/=\"$new_command\"/}" $ALIASES_FILE
  else
      # Add a new alias
      local line_with_alias=$(grep "$1=" $ALIASES_FILE)
      if [[ ! -z "$line_with_alias" ]]; then
          echo Alias found: $line_with_alias
          echo change alias by using the -c flag.
          return 1
      fi

      local lh="alias $1"
      local rh=\"${@:2}\"
      local alias_str="$lh=$rh"

      echo $alias_str >>$ALIASES_FILE
      echo added \"$alias_str\" to .aliases
  fi

  # Reload aliases
  source $ALIASES_FILE
}

function enlarge-pdf() {
  # Set default values
  local width=500
  local input
  local output

  # Parse arguments
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -o | --output )
        output="$2"
        shift 2 ;;
      -w | --width )
        width="$2"
        shift 2 ;;
      * )
        if [[ -z "$input" ]]; then
          input="$1"
        else
          echo "Error: Unknown argument $1"
          return 1
        fi
        shift ;;
    esac
  done

  # Check input file is specified
  if [[ -z "$input" ]]; then
    echo "Usage: enlarge-pdf -i INPUT_FILE [-o OUTPUT_FILE] [-w WIDTH]"
    return 1
  fi

  # Set output filename
  if [[ -z "$output" ]]; then
    output="${input%.*}_enlarged.pdf"
  fi

  # Check if output filename is valid
  if [[ -z "$output" ]]; then
    echo "Error: output filename is empty"
    return 1
  fi

  # Modify PDF file
  if ! pdf-crop-margins -o "$output" -p 100 -a4 0 0 -"$width" 0 "$input"; then
    echo "Error: Failed to modify PDF file"
    return 1
  fi
}

