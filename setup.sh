#!/bin/sh

XINITRC=$HOME/.xinitrc

#Lenovo:
#sudo pacman -S nvidia nvidia-utlis
#sudo pacman -S firefox


#Acer old:
#sudo pacman -S xf86-video-intel
#sudo pacman -S chromium
#sudo pacman -S openssh
#sudo systemctl enable sshd.service
#sudo systemctl start sshd.service

sudo pacman -S xorg xorg-xinit bspwm sxhkd dmenu nitrogen picom xfce4-terminal arandr polybar

mkdir $HOME/Aurloads
cd $HOME/Aurloads/
git clone https://aur.archlinux.org/yay.git
cd ./yay/
makepkg -si
cd $HOME/Aurloads/
yay -S pacman-contrib
#
#Acer old:
#yay -S b43-firmware
#
git clone https://github.com/catppuccin/xfce4-terminal
mkdir -p ~/.local/share/xfce4/terminal/colorschemes/
cp $HOME/Aurloads/xfce4-terminal/src/* $HOME/.local/share/xfce4/terminal/colorschemes/
yay -S vifm-git
rm -rf $HOME/.vifm/colors/ && git clone https://github.com/vifm/vifm-colors $HOME/.vifm/colors


if [ ! -d ~/.config/bswpm/ ]; then
	mkdir -p ~/.config/bspwm
fi

if [ ! -d ~/.config/sxhkd/ ]; then
	mkdir -p ~/.config/sxhkd
fi

if [ ! -d ~/.screenlayout/ ]; then
	mkdir ~/.screenlayout/
fi

cp /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/
cp /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/
cp /etc/X11/xinit/xinitrc ~/.xinitrc
sudo chmod +x .xinitrc 
grep -l "urxvt" ~/.config/sxhkd/sxhkdrc | xargs sed -i 's/urxvt/xfce4-terminal/g'


cat /etc/X11/xinit/xinitrc $XINITRC | head --lines=$(($(wc -l $XINITRC | awk '{ print $1 }') - 5)) > $XINITRC

cat <<EOF >>$XINITRC
setxkbmap en &
xsetroot -cursor_name left_ptr &
~/.screenlayout/display.sh &
picom -f &
exec bspwm
EOF

sudo /bin/sh -c "grep -l 'vsync \= true\;' /etc/xdg/picom.conf | xargs sed -i 's/vsync \= true\;/\#vsync \= true\;/g'"

touch ~/.screenlayout/display.sh && chmod +x ~/.screenlayout/display.sh

#cat <<EOF >~/.screenlayout/display.sh
#!/bin/sh
#
#xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-1 --off --output HDMI-2 --off
#EOF

sudo pacman -S nerd-fonts ttf-nerd-fonts-symbols-mono
sudo fc-cache -fv


echo "Setup Done."
#
# Acer old:
# xrandr --output LVDS1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output DP1 --off --outpu      t HDMI1 --mode 1920x1080 --pos 1915x0 --rotate normal --output VGA1 --off --output VIRTUAL1 --off --      output LVDS-1-2 --off --output VGA-1-2 --off --output HDMI-1-2 --off
#
#Extra commands:
#lspci -k | grep -A 2 -E "(VGA|3D)"
#lspci -vnn -d 14e4:
#xrandr | grep -w 'connected' | awk -F' ' '{print }'
