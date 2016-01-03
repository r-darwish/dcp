# Darwish Config Pack #

This is my repository for storing configuration files. It was tested on various Linux distributions and OS X. I should work on any Unix system,

## What's Included ##

- [tmux](https://tmux.github.io/) configuration based on [tony/tmux-config](https://github.com/tony/tmux-config).
- ZSH configuration based on [zgen](https://github.com/tarjoilija/zgen).
  - [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) and various other plugins.
  - A slightly modified version of [Spatz's prompt](https://github.com/spatz/config-files/blob/master/zsh/prompt_spatz_setup).
- A lightweight Vim configuration based on [neobundle](https://github.com/Shougo/neobundle.vim).
- [Spacemacs](https://github.com/syl20bnr/spacemacs) configuration.
- [pylintrc](http://docs.pylint.org/run.html#command-line-options).
- A couple of git aliases.
- A global gitignore file.

Spacemacs configuration is quite heavyweight and isn't desired on every host. The [minimal](https://github.com/r-darwish/dcp/tree/minimal) branch of this repository should be used when Spacemacs isn't wanted.

## Installation ##
### Using the bootstrap script ###
The bootstrap script can be used as a one-line installation for any apt/yum/pacman based linux distributions:

   $ curl https://raw.githubusercontent.com/r-darwish/dcp/master/bootstrap.sh | bash --

This script should be run as a normal user and not is root. It invokes `sudo` by itself when needed.
Basically, the script:

1. Installs required packages, which are `git`, `tmux`, `zsh`, `vim`, `python`, `emacs-nox`.
2. Clone this repository to `~/.dcp`.
3. Install DCP
4. Change the default shell to ZSH (this step requires your password)
5. Execute ZSH

Once the script is complete you should launch Vim in order to install neobundle packages and Emacs in order to install Spacemacs.

The bootstrap script should not be used on OS X. Mac users should install manually.

### Manually ###

1. Install the required packages which are specified above
2. Clone this repository by running:

    $ git clone https://github.com/r-darwish/dcp.git ~/.dcp

3. Install the repository by running:

    $ cd ~/.dcp && ./install


4. Change your default shell to ZSH
5. Launch Vim in order to install neobundle packages
6. Launch Emacs in order to install Spacemacs.

## Updating DCP ##
Just run:

    $ cd ~/.dcp && ./update && zgen update && exec zshrc
