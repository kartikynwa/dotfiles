# Hello.

## Instructions

### Set up chezmoi

Need to install [chezmoi](https://chezmoi.io) first and pull the configuration:

```
# xbps-install -Sy chezmoi
$ chezmoi init https://gitlab.com/kartikynwa/dotfiles.git
```

Most of the packages required are listed in the `packages.txt` file in the
repository. Installation can be automated using the `install_packages.sh`
script but it is recommended that you go over the packages that are being
installed.

### Apply the dotfiles


```
$ chezmoi apply --init
$ chezmoi apply
```

### Miscellaneous configuration

#### Change default shell

`chsh`

#### Add power commands to NOPASSWD

Edit `/etc/sudoers` using the `visudo` command. Add the following line:

```
%wheel ALL=(ALL) NOPASSWD: /usr/bin/halt, /usr/bin/poweroff, /usr/bin/reboot, \
            /usr/bin/shutdown, /usr/bin/zzz, /usr/bin/ZZZ
```

#### Configure laptop lid behaviour

In `/etc/acpi/handler.sh`. You know the rest (I hope).
