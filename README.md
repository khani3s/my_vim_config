How to Use
----------
  ```bash
    git clone https://github.com/khani3s/my_vim_config.git .nvim
    sudo apt-get install python3-venv cmake libboost-all-dev python3-pip
    python3 -m pip install --user --upgrade pynvim
    sudo snap install nvim --classic
    sudo snap alias nvim vim
    # Abrir o vim e executar um VundleInstall
    ln -s ~/.nvim ~/.config/nvim
    cd ~/.nvim/bundle/cpsm
    ./install.sh
  ```
