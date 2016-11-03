if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

#export XDG_CURRENT_DESKTOP=Budgie:GNOME
#exec budgie-desktop

#exec startdde

#exec i3
exec openbox-session
