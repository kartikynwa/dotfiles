# Hello.

## Screenshots

![screenshot_1](screenshots/screenshot_1.png "Naked")

## Instructions

Initiate a fresh Void Linux installation with these awesome ai machine learning
blockchain powered agile ninja powered scripts which allow quick deployment of
amazing features.

### Install Dependencies

```
# ./install_packages.sh
```

### Symlink Dotfiles 

Be careful while doing this. Do not forget to look at which files the script
symlinks. For now, the script doesn't overwrite any files but caution is advised
anyway.
```
$ ./install.sh
```

### Change default shell

`chsh`

### Add power commands to NOPASSWD

Edit `/etc/sudoers` using the `visudo` command. Add the following line:

```
%wheel ALL=(ALL) NOPASSWD: /usr/bin/halt, /usr/bin/poweroff, /usr/bin/reboot, \
            /usr/bin/shutdown, /usr/bin/zzz, /usr/bin/ZZZ
```

### Install PulseAudio

Because it works(TM). Packages needed are included in `packages.txt`. [Link to
Void Docs.](https://docs.voidlinux.org/config/media/pulseaudio.html)

### Configure laptop lid behaviour

In `/etc/acpi/handler.sh`. You know the rest (I hope).

### Font Rendering (?)

I am unsure whether this step is required but disabling bitmap fonts helps
prevent some problems (eg. with Firefox). I don't know if this works because my
laptop has a slick 720p screen which is only marginally better than literally
using a teletype.

[Blog link.](http://blog.brunomiguel.net/geekices/how-to-get-good-font-rendering-in-void-linux/)
[Archived link.](https://web.archive.org/web/20190801090733/http://blog.brunomiguel.net/geekices/how-to-get-good-font-rendering-in-void-linux/)

## Things That Do Not Matter

![Scotty2Hotty](scotty2hotty.png "Scotty2Hotty")  
© All rights reserved by Scotty2Hotty. (I think.)

Welcome to the humble abode of my _dotfiles_. They work in mysterious ways. They
have their destination (relative to `$HOME`) as a comment and a script parses
them and symlinks them there.

Adieu, friend.
