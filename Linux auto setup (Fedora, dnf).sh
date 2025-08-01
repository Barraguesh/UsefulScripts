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
░█████╗░██╗░░░██╗████████╗░█████╗░░██████╗███████╗████████╗██╗░░░██╗██████╗░  ██╗░░░██╗░░██╗██╗░░░██████╗░
██╔══██╗██║░░░██║╚══██╔══╝██╔══██╗██╔════╝██╔════╝╚══██╔══╝██║░░░██║██╔══██╗  ██║░░░██║░██╔╝██║░░░╚════██╗
███████║██║░░░██║░░░██║░░░██║░░██║╚█████╗░█████╗░░░░░██║░░░██║░░░██║██████╔╝  ╚██╗░██╔╝██╔╝░██║░░░░░███╔═╝
██╔══██║██║░░░██║░░░██║░░░██║░░██║░╚═══██╗██╔══╝░░░░░██║░░░██║░░░██║██╔═══╝░  ░╚████╔╝░███████║░░░██╔══╝░░
██║░░██║╚██████╔╝░░░██║░░░╚█████╔╝██████╔╝███████╗░░░██║░░░╚██████╔╝██║░░░░░  ░░╚██╔╝░░╚════██║██╗███████╗
╚═╝░░╚═╝░╚═════╝░░░░╚═╝░░░░╚════╝░╚═════╝░╚══════╝░░░╚═╝░░░░╚═════╝░╚═╝░░░░░  ░░░╚═╝░░░░░░░░╚═╝╚═╝╚══════╝
'
sleep 5

mkdir /tmp/AutoSetup
cd /tmp/AutoSetup

echo '
█▀▀ █▀█ █▄░█ █▀▀ █ █▀▀ █░█ █▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
█▄▄ █▄█ █░▀█ █▀░ █ █▄█ █▄█ █▀▄ █▀█ ░█░ █ █▄█ █░▀█
'

#RPM fusion - For now, don't use, too many package conflicts for my taste
#sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

sudo dnf upgrade --refresh -y

#Git credentials
sudo dnf install git -y
git config --global user.email '25356150+Barraguesh@users.noreply.github.com'
git config --global user.name 'Barraguesh'

read -p 'Do you want to reboot (recommended on first run)? (y/N) ' -n 1 -r
echo -e "\n"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo reboot
fi

read -p 'Are you dualbooting Windows? (y/N) ' -n 1 -r
echo -e "\n"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    timedatectl set-local-rtc 1 --adjust-system-clock
fi

read -p 'Install NextDNS? (y/N) ' -n 1 -r
echo -e "\n"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sh -c "$(curl -sL https://nextdns.io/install)"
fi

read -p 'Install auto-cpufreq? (y/N) ' -n 1 -r
echo -e "\n"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    git clone https://github.com/AdnanHodzic/auto-cpufreq.git
    cd auto-cpufreq && sudo ./auto-cpufreq-installer
fi

#Flatpak support
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-modify --enable flathub

#Disable Fedora flatpak repo
flatpak remote-modify fedora --disable
flatpak remote-modify fedora-testing --disable
#flatpak remote-delete fedora

#Cron
sudo dnf install cronie -y
sudo systemctl start crond.service
sudo systemctl enable crond.service

#Firewalld
sudo firewall-cmd --set-default-zone=home
sudo firewall-cmd --reload

#THIS WAS MESSY, got all kinds of conflicts after a month of using a newly installed Fedora 42... Gonna skip this and use Firefox flatpak for now

#Fedora >37 messed codec stuff up, getting how to from: https://rpmfusion.org/Howto/Multimedia?highlight=%28%5CbCategoryHowto%5Cb%29
#More docs in case I need them in the future: https://fedoraproject.org/wiki/Firefox_Hardware_acceleration
#Replace ffmpeg-free for a full version
#sudo dnf swap ffmpeg-free ffmpeg --allowerasing -y
#Additional codecs support
#sudo dnf update @multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
#Hardware Accelerated Codec - VAPI support (AMD)
#sudo dnf swap mesa-va-drivers mesa-va-drivers-freeworld -y
#sudo dnf swap mesa-vdpau-drivers mesa-vdpau-drivers-freeworld -y

#Languages for LibreOffice
sudo dnf install hunspell-es -y

#Appindicator support
sudo dnf install gnome-shell-extension-appindicator -y

#Crontab scripts
cat <<< "@reboot /home/barraguesh/Tech\ stuff/Scripts/papirus-folders-color.sh" > crontab_script; sudo crontab crontab_script
(sudo crontab -l ; echo "@reboot find /home/barraguesh/Downloads/* -maxdepth 0 -mtime +30 -exec rm -r {} +")| sudo crontab -

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
gsettings set org.gnome.desktop.wm.preferences focus-new-windows 'smart'
gsettings set org.gnome.desktop.interface clock-format '24h'

#Night light
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature "uint32 1700"
gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic true

#Dock personalization (gsettings get org.gnome.shell favorite-apps)
gsettings set org.gnome.shell favorite-apps "['org.gnome.Ptyxis.desktop', 'org.gnome.Nautilus.desktop', 'org.mozilla.firefox.desktop', 'md.obsidian.Obsidian.desktop', 'com.valvesoftware.Steam.desktop', 'com.stremio.Stremio.desktop', 'com.visualstudio.code.desktop']"
echo 'Settings applied.'

read -p 'Set up themes? (y/N) ' -n 1 -r
echo -e "\n"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo '
    ▀█▀ █░█ █▀▀ █▀▄▀█ █▀▀ █▀
    ░█░ █▀█ ██▄ █░▀░█ ██▄ ▄█
    '
    
    #General theme and Shell, use default
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    
    #Applications and Flatpak support NO LONGER NEEDED, leaving it just in case
    #flatpak install flathub org.gtk.Gtk3theme.Adwaita-Dark -y
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'

    #Icons
    sudo dnf install papirus-icon-theme -y
    gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
    
    #Papirus folders for custom folder colors
    wget -qO- https://git.io/papirus-folders-install | sh
    papirus-folders -C teal    
    
    #Cursor
    git clone https://github.com/mustafaozhan/Breeze-Adapta-Cursor.git
    sudo cp -R ./Breeze-Adapta-Cursor /usr/share/icons/Breeze\ Adapta
    gsettings set org.gnome.desktop.interface cursor-theme 'Breeze Adapta'
    echo 'Sifr (dark), recommended icon theme for Libreoffice with dark themes)'
    sleep 20
fi

read -p 'Install extensions? (y/N) ' -n 1 -r
echo -e "\n"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo '
    █▀▀ ▀▄▀ ▀█▀ █▀▀ █▄░█ █▀ █ █▀█ █▄░█ █▀
    ██▄ █░█ ░█░ ██▄ █░▀█ ▄█ █ █▄█ █░▀█ ▄█
    '
    sleep 5
    
    firefox 'https://extensions.gnome.org/extension/3843/just-perfection/'
    firefox 'https://extensions.gnome.org/extension/615/appindicator-support/'
    firefox 'https://extensions.gnome.org/extension/3193/blur-my-shell/'
    firefox 'https://extensions.gnome.org/extension/5660/weather-or-not/'
    firefox 'https://extensions.gnome.org/extension/307/dash-to-dock/'
    firefox 'https://extensions.gnome.org/extension/352/middle-click-to-close-in-overview/'
    firefox 'https://extensions.gnome.org/extension/6385/steal-my-focus-window/'
    #Solaar tray icon is broken, with this extension, that is objectively better for tray icons
    #firefox 'https://extensions.gnome.org/extension/2890/tray-icons-reloaded/'
fi

read -p 'Install apps? (y/N) ' -n 1 -r
echo -e "\n"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo '
    ▄▀█ █▀█ █▀█ █▀
    █▀█ █▀▀ █▀▀ ▄█
    '
    sleep 5
    
    #Removal of unwanted apps
    sudo dnf remove gedit -y
    sudo dnf remove gnome-text-editor -y
    sudo dnf remove totem -y
    sudo dnf remove rhythmbox -y
    sudo dnf remove libreoffice* -y
    sudo dnf remove firefox -y
    sudo dnf remove evince -y
    
    #Non flatpak apps
    sudo dnf install neofetch -y
    sudo dnf install openssl -y
    sudo dnf install htop -y
    sudo dnf install lm_sensors -y
    sudo dnf install evolution -y
    sudo dnf install gnome-tweak-tool  -y
    sudo dnf install solaar -y
    sudo dnf install wine -y
    
    #Flatpak apps
    flatpak install flathub org.mozilla.firefox -y
    flatpak install flathub org.gnome.Papers -y
    flatpak install flathub org.gnome.Music -y
    flatpak install flathub org.cryptomator.Cryptomator -y
    flatpak install flathub com.obsproject.Studio -y
    flatpak install flathub com.stremio.Stremio -y
    flatpak install flathub org.videolan.VLC -y
    flatpak install flathub com.github.philip_scott.spice-up -y
    flatpak install flathub org.kde.kdenlive -y
    flatpak install flathub org.fedoraproject.MediaWriter -y
    flatpak install flathub com.transmissionbt.Transmission -y
    flatpak install flathub org.gnome.Extensions -y
    flatpak install flathub com.calibre_ebook.calibre -y
    flatpak install flathub com.github.tchx84.Flatseal -y
    flatpak install flathub md.obsidian.Obsidian -y
    flatpak install flathub com.visualstudio.code -y
    flatpak install flathub org.libreoffice.LibreOffice -y
    flatpak install flathub org.gnome.NetworkDisplays -y
    flatpak install flathub io.missioncenter.MissionCenter -y
    
    #Steam and Proton GE
    flatpak install flathub com.valvesoftware.Steam -y
    flatpak install com.valvesoftware.Steam.CompatibilityTool.Proton-GE -y
    #sudo dnf install steam-devices -y
    
    #Useful apps not marked for install
    #flatpak install flathub org.musicbrainz.Picard -y
    #flatpak install flathub com.belmoussaoui.Obfuscate -y
    #flatpak install org.freedesktop.Platform.ffmpeg-full -y
fi

cd /tmp
sudo rm -rf AutoSetup

echo '
███╗░░░███╗░█████╗░░█████╗░██╗░░██╗██╗███╗░░██╗███████╗  ██████╗░███████╗░█████╗░██████╗░██╗░░░██╗
████╗░████║██╔══██╗██╔══██╗██║░░██║██║████╗░██║██╔════╝  ██╔══██╗██╔════╝██╔══██╗██╔══██╗╚██╗░██╔╝
██╔████╔██║███████║██║░░╚═╝███████║██║██╔██╗██║█████╗░░  ██████╔╝█████╗░░███████║██║░░██║░╚████╔╝░
██║╚██╔╝██║██╔══██║██║░░██╗██╔══██║██║██║╚████║██╔══╝░░  ██╔══██╗██╔══╝░░██╔══██║██║░░██║░░╚██╔╝░░
██║░╚═╝░██║██║░░██║╚█████╔╝██║░░██║██║██║░╚███║███████╗  ██║░░██║███████╗██║░░██║██████╔╝░░░██║░░░
╚═╝░░░░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝╚═╝╚═╝░░╚══╝╚══════╝  ╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝╚═════╝░░░░╚═╝░░░
'

echo 'Restarting is recommended'
