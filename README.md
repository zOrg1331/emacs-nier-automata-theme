# Info

A color theme for [Emacs](https://www.gnu.org/software/emacs/) based on [Nier:
Automata](https://en.wikipedia.org/wiki/Nier:_Automata) video game colors.

# Screenshots

![Emacs picture 1](https://github.com/zOrg1331/emacs-nier-automata-theme/blob/main/images/emacs1.png)

# Installation

## Spacemacs

Add theme to the list of `dotspacemacs-themes`:
```elisp
(defun dotspacemacs/init ()
...
   dotspacemacs-themes '(
                         (nier-automata :location local)
                         spacemacs-dark
                         spacemacs-light
                         )
```

In `~/.emacs.d/private/local` create a symbolic link pointing to the cloned
repository with name `nier-automata` as shown here:
```
❯ tree ~/.emacs.d/private/local
/home/user/.emacs.d/private/local
├── nier-automata-theme -> /home/user/emacs-nier-automata-theme
└── README.md

2 directories, 1 file
```
