import os

current_path = os.getcwd()
user = os.environ.get("USER")
supposed_path = f"/home/{user}/.config"

######################## util functions ########################################

def compress_the_configs(targets: list):
    command_head = "tar -cpvzf kde_backup.tar.gz "
    command_tail = " ".join(targets)
    my_command = command_head + command_tail
    os.system(my_command)


################################################################################

assert current_path == supposed_path, "Please run this script in the config folder"

with open("backup_list.txt") as f:
    # using split(\n) will have a blank at the last element, using [:-1] to get rid of it.
    targets = f.read().split("\n")[:-1]
    
configs = os.listdir()

backup_dirs = []
backup_files = []

count = 0
for i, name in enumerate(targets):
    if name not in configs:
        # print(f"{name} found in the config")
        print(f"{name} not found in this config", f"{i}th")
    else:
        # distinguishing the folder and the file
        count += 1

        abs_path = os.path.join(current_path, name)

        if os.path.isdir(abs_path):
            backup_dirs.append(name)
        elif os.path.isfile(abs_path):
            backup_files.append(name)
        else:
            print(f"that is weird, {name} is neither a directory nor a file.")

print(len(backup_dirs), " is the number of directories")
print(len(backup_files), " is the number of files")
print(f"total number of backups is {count}")

compress_the_configs(targets)



