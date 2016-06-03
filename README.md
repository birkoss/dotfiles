To install
----------

git clone https://github.com/birkoss/dotfiles.git

Update .bashrc
--------------

echo "[[ -r ~/.bash_profile ]] && . ~/.bash_profile" >> .bashrc

Create symlinks
---------------

* ln -s {/path/to/dotfiles/.vimrc} ~/.vimrc
* ln -s {/path/to/dotfiles/.vim} ~/.vim
* ln -s {/path/to/dotfiles/.bash_completion} ~/.bash_completion
* ln -s {/path/to/dotfiles/.bash_profile} ~/.bash_profile

Local VIM config
----------------

Create a **~/.vimrc_local**

Quicker search (Optional)

apt install silversearcher-ag
