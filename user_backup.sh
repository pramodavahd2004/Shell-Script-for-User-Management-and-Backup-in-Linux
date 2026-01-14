#!/bin/bash

BACKUP_DIR="/backup"
DATE=$(date +%F)

show_menu() {
    echo "-------------------------------------"
    echo " User Management & Backup System "
    echo "-------------------------------------"
    echo "1. Add User"
    echo "2. Delete User"
    echo "3. Modify User (Change Shell)"
    echo "4. Create Group"
    echo "5. Add User to Group"
    echo "6. Take Backup of Directory"
    echo "7. Exit"
    echo "-------------------------------------"
}

add_user() {
    read -p "Enter username: " user
    sudo useradd $user && echo "User $user added successfully."
}

delete_user() {
    read -p "Enter username: " user
    sudo userdel -r $user && echo "User $user deleted successfully."
}

modify_user() {
    read -p "Enter username: " user
    read -p "Enter new shell (e.g. /bin/bash): " shell
    sudo usermod -s $shell $user && echo "Shell updated for $user."
}

create_group() {
    read -p "Enter group name: " group
    sudo groupadd $group && echo "Group $group created."
}

add_user_to_group() {
    read -p "Enter username: " user
    read -p "Enter group name: " group
    sudo usermod -aG $group $user && echo "User $user added to group $group."
}

backup_directory() {
    read -p "Enter directory path to backup: " dir
    mkdir -p $BACKUP_DIR
    tar -czvf $BACKUP_DIR/backup_$DATE.tar.gz $dir
    echo "Backup created at $BACKUP_DIR/backup_$DATE.tar.gz"
}

while true
do
    show_menu
    read -p "Choose an option: " choice

    case $choice in
        1) add_user ;;
        2) delete_user ;;
        3) modify_user ;;
        4) create_group ;;
        5) add_user_to_group ;;
        6) backup_directory ;;
        7) echo "Exiting..."; exit ;;
        *) echo "Invalid option. Try again." ;;
    esac
done
