# This is a comprehensive guide for gnome settings.

[![ARCH](https://upload.wikimedia.org/wikipedia/commons/8/82/Gnu-bash-logo.svg)](https://wiki.archlinux.org/title/GNOME#Advanced_settings)

## Themes
To select new themes (move them to the appropriate directory and) use GNOME Tweaks or the GSettings commands below:

### For the GTK theme:
```ssh
gsettings set org.gnome.desktop.interface gtk-theme Adwaita
```

### For the icon theme:
```ssh
$ gsettings set org.gnome.desktop.interface icon-theme Adwaita
```

### prefer Dark Style:
```ssh
$ gsettings set org.gnome.desktop.interface color-scheme prefer-dark
```

### Titlebar button order
```ssh
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'
```

### Lock screen and background image
```sh
gsettings set org.gnome.desktop.background picture-uri 'file:///home/sam/envconfig/images/blobs-l.svg'
```
```sh
gsettings set org.gnome.desktop.screensaver picture-uri 'file:///home/sam/envconfig/image/blobs-l.svg'
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

### Titlebar Height.
> edit file ~/.config/gtk-3.0/gtk.css
```sh
/* shrink headerbars (don't forget semicolons after each property) */
headerbar {
    min-height: 0px;
    padding-left: 2px; /* same as childrens vertical margins for nicer proportions */
    padding-right: 2px;
    background-color: #2d2d2d;
}

headerbar entry,
headerbar spinbutton,
headerbar button,
headerbar separator {
    margin-top: 0px; /* same as headerbar side padding for nicer proportions */
    margin-bottom: 0px;
}

/* shrink ssd titlebars */
.default-decoration {
    min-height: 0; /* let the entry and button drive the titlebar size */
    padding: 0px;
    background-color: #2d2d2d;
}

.default-decoration .titlebutton {
    min-height: 0px; /* tweak these two props to reduce button size */
    min-width: 0px;
}

window.ssd headerbar.titlebar {
    padding-top: 3px;
    padding-bottom: 3px;
    min-height: 0;
}

window.ssd headerbar.titlebar button.titlebutton {
    padding-top: 3px;
    padding-bottom:3px;
    min-height: 0;
}
```
