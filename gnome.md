# This is a comprehensive guide for gnome settings.

[![N|Solid](https://cldup.com/dTxpPi9lDf.thumb.png)](https://wiki.archlinux.org/title/GNOME#Advanced_settings)

## Themes
To select new themes (move them to the appropriate directory and) use GNOME Tweaks or the GSettings commands below:

### For the GTK theme:
```ssh
gsettings set org.gnome.desktop.interface gtk-theme theme-name
```

### For the icon theme:
```ssh
$ gsettings set org.gnome.desktop.interface icon-theme theme-name
```

### Titlebar button order
```ssh
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'
```

### Lock screen and background image
```sh
gsettings set org.gnome.desktop.background picture-uri 'file:///path/to/my/picture.jpg'
```
```sh
gsettings set org.gnome.desktop.screensaver picture-uri 'file:///path/to/my/picture.jpg'
```

### Disable top left hot corner
```sh
gsettings set org.gnome.desktop.interface enable-hot-corners false
```

### Night Light
```sh
gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 2700
```

### Date & time
To show the date in the top bar, execute:
```sh
gsettings set org.gnome.desktop.interface clock-show-date true
```
Additionally, to show week numbers in the calendar opened on the top bar, execute:
```ssh
gsettings set org.gnome.desktop.calendar show-weekdate true
```

### Mouse & Touchpad
```sh
gsettings set org.gnome.desktop.peripherals.touchpad click-method 'fingers'
```
