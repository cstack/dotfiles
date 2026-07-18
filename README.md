dotfiles
========

My dotfiles, should I need them on another machine.

In ~/.bashrc, add: ```source ~/Development/dotfiles/.bashrc```

For zsh, symlink the repo file:

```sh
ln -s ~/Development/dotfiles/.zshrc ~/.zshrc
```

Machine-local secrets and settings can live in `~/.zshrc.local`.
