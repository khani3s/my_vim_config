How to Use
----------
 
0. Git Clone into your home directory and rename to .vim

        git clone https://github.com/khani3s/my_vim_config.git .vim

1. Link the .vimrc

        ln -s .vim/.vimrc .vimrc

2. Install gvim 

        sudo apt-get install vim-gnome 

3. Configure your terminal to accept 256 color 

  For Ubuntu users with Bash and Xterm, append this line to the end of your .bashrc

        export TERM=xterm-256color

4. Open the command-t-1.3.1.vba with vim and run 

        so % 

  **Press spacebar on every "more" or it will not install correctly!** 

5. Run the follow commands inside the ruby/command-t folder: 

        ruby extconf.rb 
        make 
