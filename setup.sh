#!/bin/sh

XINITRC=$HOME/.xinitrc
#sudo pacman -S wget
#sudo pacman -S nvidia nvidia-utlis &&
#sudo pacman -S xorg xorg-xinit bspwm sxhkd dmenu nitrogen picom
xfce4-terminal firefox arandr polybar

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

cat <<EOF >~/.screenlayout/display.sh
#!/bin/sh
#

xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --off --output DP-1 --off --output HDMI-2 --off
EOF
