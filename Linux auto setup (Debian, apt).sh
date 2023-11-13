#!/bin/bash
#
#I reset my devices so much that I got tired and tried to automate most of the install, hope to not
#distro hop, because it will be a pain in the ass to research new issues to automate the fixing
#
#Script by Barraguesh. Text made with https://fsymbols.com/generators/tarty/
#

echo 'Fullscreen is recomended for readability'
sleep 2

echo '
░█████╗░██╗░░░██╗████████╗░█████╗░░██████╗███████╗████████╗██╗░░░██╗██████╗░  ██╗░░░██╗░░██╗██╗░░░░░███╗░░
██╔══██╗██║░░░██║╚══██╔══╝██╔══██╗██╔════╝██╔════╝╚══██╔══╝██║░░░██║██╔══██╗  ██║░░░██║░██╔╝██║░░░░████║░░
███████║██║░░░██║░░░██║░░░██║░░██║╚█████╗░█████╗░░░░░██║░░░██║░░░██║██████╔╝  ╚██╗░██╔╝██╔╝░██║░░░██╔██║░░
██╔══██║██║░░░██║░░░██║░░░██║░░██║░╚═══██╗██╔══╝░░░░░██║░░░██║░░░██║██╔═══╝░  ░╚████╔╝░███████║░░░╚═╝██║░░
██║░░██║╚██████╔╝░░░██║░░░╚█████╔╝██████╔╝███████╗░░░██║░░░╚██████╔╝██║░░░░░  ░░╚██╔╝░░╚════██║██╗███████╗
╚═╝░░╚═╝░╚═════╝░░░░╚═╝░░░░╚════╝░╚═════╝░╚══════╝░░░╚═╝░░░░╚═════╝░╚═╝░░░░░  ░░░╚═╝░░░░░░░░╚═╝╚═╝╚══════╝
'
sleep 5

#Root needed for Debian
su root

mkdir /tmp/AutoSetup
cd /tmp/AutoSetup

echo '
█▀▀ █▀█ █▄░█ █▀▀ █ █▀▀ █░█ █▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
█▄▄ █▄█ █░▀█ █▀░ █ █▄█ █▄█ █▀▄ █▀█ ░█░ █ █▄█ █░▀█
'

#Update and clean install
apt update -y && apt upgrade -y && apt autoclean -y && apt autopurge -y

#Automatic updates
apt install unattended-upgrades -y

#Git credentials
sudo apt install git -y
git config --global user.email '25356150+Barraguesh@users.noreply.github.com'
git config --global user.name 'Barraguesh'

read -p 'Are you dualbooting Windows? (y/N) ' -n 1 -r
echo -e "\n"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    timedatectl set-local-rtc 1 --adjust-system-clock
    #OS prober for dualboot OS detection
    apt install os-prober -y
fi

read -p 'Install NextDNS? (y/N) ' -n 1 -r
echo -e "\n"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    apt install curl -y
    sh -c "$(curl -sL https://nextdns.io/install)"
fi

read -p 'Install auto-cpufreq? (y/N) ' -n 1 -r
echo -e "\n"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    git clone https://github.com/AdnanHodzic/auto-cpufreq.git
    cd auto-cpufreq && sudo ./auto-cpufreq-installer
fi

#Flatpak support
apt install flatpak -y
apt install gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#Firewalld
apt install ufw -y
sudo ufw default deny incoming
sudo ufw default allow outgoing

#ClamAV
sudo apt install clamav -y

#VAPI support (Fedora >37 doesn't include it). Note: Seems that Flatpak apps bundle it so I won't be needing it while I use them.
#sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld --allowerasing -y
#sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld --allowerasing -y

#Languages for LibreOffice
apt install hunspell-es -y

#Appindicator support
apt install gnome-shell-extension-appindicator -y



read -p 'Set up themes? (y/N) ' -n 1 -r
echo -e "\n"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo '
    ▀█▀ █░█ █▀▀ █▀▄▀█ █▀▀ █▀
    ░█░ █▀█ ██▄ █░▀░█ ██▄ ▄█
    '

    #Applications and Flatpak support
    flatpak install flathub org.gtk.Gtk3theme.Adwaita-Dark -y

    #Papirus folders for custom folder colors
    wget -qO- https://git.io/papirus-folders-install | sh
    papirus-folders -C teal
    cat <<< "@reboot /home/barraguesh/Tech\ stuff/Scripts/papirus-folders-color.sh" > crontab_script; sudo crontab crontab_script

    #Icons
    apt install papirus-icon-theme -y
  
    #Cursor
    git clone https://github.com/mustafaozhan/Breeze-Adapta-Cursor.git
    cp -R ./Breeze-Adapta-Cursor /usr/share/icons/Breeze\ Adapta
fi

read -p 'Install extensions? (y/N) ' -n 1 -r
echo -e "\n"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo '
    █▀▀ ▀▄▀ ▀█▀ █▀▀ █▄░█ █▀ █ █▀█ █▄░█ █▀
    ██▄ █░█ ░█░ ██▄ █░▀█ ▄█ █ █▄█ █░▀█ ▄█
    '
    sleep 5

    #ToDo Firefox esr cant be launched from root
    firefox-esr 'https://extensions.gnome.org/extension/3843/just-perfection/'
    firefox-esr 'https://extensions.gnome.org/extension/2890/tray-icons-reloaded/'
    firefox-esr 'https://extensions.gnome.org/extension/1401/bluetooth-quick-connect/'
    firefox-esr 'https://extensions.gnome.org/extension/3193/blur-my-shell/'
    firefox-esr 'https://extensions.gnome.org/extension/2182/noannoyance/'
fi

read -p 'Install apps? (y/N) ' -n 1 -r
echo -e "\n"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo '
    ▄▀█ █▀█ █▀█ █▀
    █▀█ █▀▀ █▀▀ ▄█
    '
    sleep 5
    
    #Removal
    apt remove gedit -y
    apt remove evince -y
    apt remove firefox-esr -y
    apt remove totem -y
    apt remove gnome-photos -y
    apt remove libreoffice* -y
    apt remove rhythmbox -y
    apt remove gnome-text-editor -y
    
    #Terminal apps
    apt install neofetch -y
    apt install openssl -y
    apt install htop -y
    apt install lm-sensors -y
    apt install evolution -y
    
    #Flatpak apps
    flatpak install flathub org.mozilla.firefox -y
    flatpak install org.freedesktop.Platform.ffmpeg-full -y
    flatpak install flathub org.gnome.Music -y
    flatpak install flathub org.gnome.Photos -y
    flatpak install flathub org.libreoffice.LibreOffice -y
    flatpak install flathub org.gnome.Evince -y
    flatpak install flathub org.cryptomator.Cryptomator -y
    flatpak install flathub com.obsproject.Studio -y
    flatpak install flathub org.chromium.Chromium -y
    flatpak install flathub com.stremio.Stremio -y
    flatpak install flathub org.videolan.VLC -y
    flatpak install flathub com.github.philip_scott.spice-up -y
    flatpak install flathub org.kde.kdenlive -y
    flatpak install flathub org.fedoraproject.MediaWriter -y
    flatpak install flathub com.transmissionbt.Transmission -y
    flatpak install flathub org.gnome.Extensions -y
    flatpak install flathub com.mattjakeman.ExtensionManager -y
    flatpak install flathub com.github.tchx84.Flatseal -y
    flatpak install flathub com.visualstudio.code
    
    #Steam and Proton GE
    flatpak install flathub com.valvesoftware.Steam -y
    flatpak install com.valvesoftware.Steam.CompatibilityTool.Proton-GE -y
    sudo dnf install steam-devices -y
    
    #Useful apps not marked for install
    #flatpak install flathub org.musicbrainz.Picard -y
    #flatpak install flathub com.belmoussaoui.Obfuscate -y
    #sudo dnf install gnome-tweak-tool  -y
fi

cd /tmp
sudo rm -rf AutoSetup

#Remove and update stuff
apt upgrade -y && apt update -y && apt autoclean -y && apt autopurge -y

exit

echo '
█▀▀ █▄░█ █▀█ █▀▄▀█ █▀▀   █▀ █▀▀ ▀█▀ ▀█▀ █ █▄░█ █▀▀ █▀
█▄█ █░▀█ █▄█ █░▀░█ ██▄   ▄█ ██▄ ░█░ ░█░ █ █░▀█ █▄█ ▄█
'

#Use "dconf watch /" and use tweaks/tools to see changes and create commands
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
gsettings set org.gnome.desktop.interface font-name 'Liberation Sans 12'
gsettings set org.gnome.desktop.interface document-font-name 'Liberation Sans 12'
gsettings set org.gnome.desktop.interface monospace-font-name 'Liberation Mono 12'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Liberation Sans Bold 12'
gsettings set org.gnome.desktop.peripherals.touchpad click-method 'areas'
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.datetime automatic-timezone true
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.desktop.session idle-delay "uint32 600"
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'suspend'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 7200
gsettings set org.gnome.desktop.interface enable-hot-corners true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.software download-updates-notify false
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us+altgr-intl')]"
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'nothing'
gsettings set org.gnome.desktop.privacy remember-recent-files true
gsettings set org.gnome.desktop.privacy recent-files-max-age 7
gsettings set org.gnome.desktop.privacy remove-old-trash-files true
gsettings set org.gnome.desktop.privacy remove-old-temp-files true
gsettings set org.gnome.desktop.privacy old-files-age "uint32 14"
gsettings set org.gnome.shell had-bluetooth-devices-setup true
gsettings set org.gnome.nautilus.preferences show-delete-permanently true
dconf write /org/gtk/gtk4/settings/file-chooser/sort-directories-first true

#Night light
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature "uint32 1700"
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic true

#Dock personalization (gsettings get org.gnome.shell favorite-apps)
gsettings set org.gnome.shell favorite-apps "['org.gnome.Terminal.desktop', 'org.gnome.Nautilus.desktop', 'org.mozilla.firefox.desktop', 'com.valvesoftware.Steam.desktop', 'com.stremio.Stremio.desktop']"

#General theme and Shell, use default
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

#Applications and Flatpak support
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'


gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'

#Cursor
gsettings set org.gnome.desktop.interface cursor-theme 'Breeze Adapta'
echo 'Sifr (dark), recommended icon theme for Libreoffice with dark themes)'
sleep 20

echo 'Settings applied.'

echo '
███╗░░░███╗░█████╗░░█████╗░██╗░░██╗██╗███╗░░██╗███████╗  ██████╗░███████╗░█████╗░██████╗░██╗░░░██╗
████╗░████║██╔══██╗██╔══██╗██║░░██║██║████╗░██║██╔════╝  ██╔══██╗██╔════╝██╔══██╗██╔══██╗╚██╗░██╔╝
██╔████╔██║███████║██║░░╚═╝███████║██║██╔██╗██║█████╗░░  ██████╔╝█████╗░░███████║██║░░██║░╚████╔╝░
██║╚██╔╝██║██╔══██║██║░░██╗██╔══██║██║██║╚████║██╔══╝░░  ██╔══██╗██╔══╝░░██╔══██║██║░░██║░░╚██╔╝░░
██║░╚═╝░██║██║░░██║╚█████╔╝██║░░██║██║██║░╚███║███████╗  ██║░░██║███████╗██║░░██║██████╔╝░░░██║░░░
╚═╝░░░░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝╚═╝╚═╝░░╚══╝╚══════╝  ╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚═════╝░░░░╚═╝░░░
'

echo 'Restarting is recommended'
