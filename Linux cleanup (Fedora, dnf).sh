#!/bin/bash

sudo echo -e "\033[1m\033[7mStarting system updates...\033[0m"

sudo dnf autoremove -y
sudo dnf -y clean all
flatpak uninstall --unused -y
flatpak -y update
sudo dnf upgrade --refresh -y 

echo "System updates have been completed. What would you like to do next?"
echo "1. Reboot"
echo "2. Power-off"
echo "3. Exit"

read choice

case $choice in
  1)
    sudo reboot
    ;;
  2)
    sudo poweroff
    ;;
  3)
    exit
    ;;
  *)
    echo "Invalid choice. Please choose 1, 2, or 3."
    ;;
esac
