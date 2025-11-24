#!/bin/bash
#
#I reset my devices so much that I got tired and tried to automate most of the install, hope to not
#distro hop, because it will be a pain in the ass to research new issues to automate the fixing
#
#Script by Barraguesh. Text made with https://fsymbols.com/generators/tarty/
#

echo 'Fullscreen is recomended for readability'
sleep 4

echo '

███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
█░░░░░░░░░░░░░░█░░░░░░██░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░██░░░░░░█░░░░░░░░░░░░░░████░░░░░░██░░░░░░█░░░░░░░░░░░░░░████████░░░░░░░░░░░░░░█
█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░████░░▄▀░░██░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░████████░░▄▀▄▀▄▀▄▀▄▀░░█
█░░▄▀░░░░░░▄▀░░█░░▄▀░░██░░▄▀░░█░░░░░░▄▀░░░░░░█░░▄▀░░░░░░▄▀░░█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░░░░░█░░░░░░▄▀░░░░░░█░░▄▀░░██░░▄▀░░█░░▄▀░░░░░░▄▀░░████░░▄▀░░██░░▄▀░░█░░▄▀░░░░░░░░░░████████░░▄▀░░░░░░▄▀░░█
█░░▄▀░░██░░▄▀░░█░░▄▀░░██░░▄▀░░█████░░▄▀░░█████░░▄▀░░██░░▄▀░░█░░▄▀░░█████████░░▄▀░░█████████████░░▄▀░░█████░░▄▀░░██░░▄▀░░█░░▄▀░░██░░▄▀░░████░░▄▀░░██░░▄▀░░█░░▄▀░░████████████████░░▄▀░░██░░▄▀░░█
█░░▄▀░░░░░░▄▀░░█░░▄▀░░██░░▄▀░░█████░░▄▀░░█████░░▄▀░░██░░▄▀░░█░░▄▀░░░░░░░░░░█░░▄▀░░░░░░░░░░█████░░▄▀░░█████░░▄▀░░██░░▄▀░░█░░▄▀░░░░░░▄▀░░████░░▄▀░░██░░▄▀░░█░░▄▀░░░░░░░░░░████████░░▄▀░░██░░▄▀░░█
█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██░░▄▀░░█████░░▄▀░░█████░░▄▀░░██░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█████░░▄▀░░█████░░▄▀░░██░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░████░░▄▀░░██░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░████████░░▄▀░░██░░▄▀░░█
█░░▄▀░░░░░░▄▀░░█░░▄▀░░██░░▄▀░░█████░░▄▀░░█████░░▄▀░░██░░▄▀░░█░░░░░░░░░░▄▀░░█░░▄▀░░░░░░░░░░█████░░▄▀░░█████░░▄▀░░██░░▄▀░░█░░▄▀░░░░░░░░░░████░░▄▀░░██░░▄▀░░█░░░░░░░░░░▄▀░░████████░░▄▀░░██░░▄▀░░█
█░░▄▀░░██░░▄▀░░█░░▄▀░░██░░▄▀░░█████░░▄▀░░█████░░▄▀░░██░░▄▀░░█████████░░▄▀░░█░░▄▀░░█████████████░░▄▀░░█████░░▄▀░░██░░▄▀░░█░░▄▀░░████████████░░▄▀▄▀░░▄▀▄▀░░█████████░░▄▀░░████████░░▄▀░░██░░▄▀░░█
█░░▄▀░░██░░▄▀░░█░░▄▀░░░░░░▄▀░░█████░░▄▀░░█████░░▄▀░░░░░░▄▀░░█░░░░░░░░░░▄▀░░█░░▄▀░░░░░░░░░░█████░░▄▀░░█████░░▄▀░░░░░░▄▀░░█░░▄▀░░████████████░░░░▄▀▄▀▄▀░░░░█░░░░░░░░░░▄▀░░█░░░░░░█░░▄▀░░░░░░▄▀░░█
█░░▄▀░░██░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█████░░▄▀░░█████░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█████░░▄▀░░█████░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░██████████████░░░░▄▀░░░░███░░▄▀▄▀▄▀▄▀▄▀░░█░░▄▀░░█░░▄▀▄▀▄▀▄▀▄▀░░█
█░░░░░░██░░░░░░█░░░░░░░░░░░░░░█████░░░░░░█████░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█░░░░░░░░░░░░░░█████░░░░░░█████░░░░░░░░░░░░░░█░░░░░░████████████████░░░░░░█████░░░░░░░░░░░░░░█░░░░░░█░░░░░░░░░░░░░░█
███████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████
'
sleep 5

mkdir /tmp/AutoSetup
cd /tmp/AutoSetup

echo '
█▀▀ █▀█ █▄░█ █▀▀ █ █▀▀ █░█ █▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
█▄▄ █▄█ █░▀█ █▀░ █ █▄█ █▄█ █▀▄ █▀█ ░█░ █ █▄█ █░▀█
'

# Install of RPM images
read -p 'Install RPM images (first run)? (y/N) ' -n 1 -r
echo -e "\n"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rpm-ostree install git -y
    rpm-ostree install gnome-shell-extension-appindicator -y
    rpm-ostree install papirus-icon-theme -y
    rpm-ostree install neofetch -y
    rpm-ostree install openssl -y
    rpm-ostree install htop -y
    rpm-ostree install lm_sensors -y
    systemctl reboot
fi

#Git credentials
git config --global user.email '25356150+Barraguesh@users.noreply.github.com'
git config --global user.name 'Barraguesh'

read -p 'Are you dualbooting Windows? (y/N) ' -n 1 -r
echo -e "\n"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    timedatectl set-local-rtc 1 --adjust-system-clock
fi

#Flatpak support
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-modify --enable flathub

#Firewalld
#Local Filen webdav port
#sudo firewall-cmd --zone=home --add-port=1900/tcp --permanent
sudo firewall-cmd --set-default-zone=home
sudo firewall-cmd --reload

# Downloads cleanup script
cat >> ./downloads_cleanup.service << 'END'
[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/bin/bash -c “find /home/barraguesh/Downloads/* -maxdepth 0 -mtime +60 -exec rm -r {} +”

[Install]
WantedBy=multi-user.target
END
sudo cp ./downloads_cleanup.service /etc/systemd/system/
sudo systemctl enable downloads_cleanup.service

# Papirus folders script
cat >> ./papirus_folders_color.service << 'END'
[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/bin/bash -c “/home/barraguesh/Tech\ stuff/Scripts/papirus-folders-color.sh”

[Install]
WantedBy=multi-user.target
END
sudo cp ./papirus_folders_color.service /etc/systemd/system/
sudo systemctl enable papirus_folders_color.service

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
fi

read -p 'Setup Gnome? (y/N) ' -n 1 -r
echo -e "\n"
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
    dconf write /org/gnome/desktop/peripherals/mouse/speed0.45299145299145294

    #Night light
    gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
    gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature "uint32 1700"
    gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic true
    
    #Dock personalization (gsettings get org.gnome.shell favorite-apps)
    gsettings set org.gnome.shell favorite-apps "['org.gnome.Ptyxis.desktop', 'org.gnome.Nautilus.desktop', 'org.mozilla.firefox.desktop', 'com.bitwarden.desktop.desktop', 'md.obsidian.Obsidian.desktop', 'com.valvesoftware.Steam.desktop', 'org.gnome.Music.desktop', 'com.stremio.Stremio.desktop', 'com.visualstudio.code.desktop']"

    #Extensions config
    dconf write /org/gnome/shell/extensions/just-perfection/window-demands-attention-focus true
    dconf write /org/gnome/shell/extensions/just-perfection/world-clock false
    dconf write /org/gnome/shell/extensions/just-perfection/search false
    dconf write /org/gnome/shell/extensions/just-perfection/startup-status 0
    
    dconf write /org/gnome/shell/extensions/blur-my-shell/panel/blur true
    dconf write /org/gnome/shell/extensions/blur-my-shell/applications/sigma 5
    dconf write /org/gnome/shell/extensions/blur-my-shell/applications/opacity 200
    dconf write /org/gnome/shell/extensions/blur-my-shell/applications/dynamic-opacity true
    dconf write /org/gnome/shell/extensions/blur-my-shell/applications/enable-all true
    
    dconf write /org/gnome/shell/extensions/dash-to-dock/dock-fixed false
    dconf write /org/gnome/shell/extensions/dash-to-dock/transparency-mode 'DYNAMIC'
    dconf write /org/gnome/shell/extensions/dash-to-dock/click-action 'minimize'
    dconf write /org/gnome/shell/extensions/dash-to-dock/hot-keys false
    dconf write /org/gnome/shell/extensions/dash-to-dock/height-fraction 0.90000000000000002
    dconf write /org/gnome/shell/extensions/dash-to-dock/dash-max-icon-size 64
    
    dconf write /org/gnome/shell/extensions/trayIconsReloaded/icon-size 18
    dconf write /org/gnome/shell/extensions/trayIconsReloaded/icon-padding-horizontal 6
    dconf write /org/gnome/shell/extensions/trayIconsReloaded/icon-margin-horizontal 2
    dconf write /org/gnome/shell/extensions/trayIconsReloaded/tray-margin-right 0
    
    echo 'Settings applied.'
fi

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

read -p 'Install apps? (y/N) ' -n 1 -r
echo -e "\n"
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo '
    ▄▀█ █▀█ █▀█ █▀
    █▀█ █▀▀ █▀▀ ▄█
    '
    sleep 5    
    
    #Flatpak apps
    flatpak install flathub org.mozilla.firefox -y
    flatpak install org.freedesktop.Platform.ffmpeg-full -y
    flatpak install flathub org.chromium.Chromium -y
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
    #flatpak install flathub org.libreoffice.LibreOffice -y
    flatpak install flathub org.gnome.NetworkDisplays -y
    flatpak install flathub io.missioncenter.MissionCenter -y
    flatpak install flathub org.musicbrainz.Picard -y
    flatpak install flathub com.bitwarden.desktop -y
    flatpak install flathub com.binarynonsense.acbr -y
    flatpak install flathub com.jetbrains.IntelliJ-IDEA-Community -y
    
    #Steam and Proton GE
    flatpak install flathub com.valvesoftware.Steam -y
    flatpak install com.valvesoftware.Steam.CompatibilityTool.Proton-GE -y
    
    #Useful apps not marked for install
    #flatpak install flathub com.belmoussaoui.Obfuscate -y

    #Removal of RPM apps
    rpm-ostree override remove firefox     
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
