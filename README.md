# Install

    cd ~
    sudo apt-get -y install git
    git clone git://github.com/christophermanning/dotfiles.git ~/.dotfiles
    pushd .dotfiles
    chmod u+x install.sh 
    ./install.sh
    popd
    rcup rcrc
    rcup

