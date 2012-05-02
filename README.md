== My Vim Configuration

1. Install gvim

    sudo apt-get install vim-gnome

2. Configure your terminal to accept 256 color

    export TERM=xterm-256color

3. Open the command-t-1.3.1.vba with vim and run

    so %

* Press spacebar on "more" or it will not install correctly!

4. Run the follow commands inside the ruby/command-t folder:

    ruby extconf.rb
    make
