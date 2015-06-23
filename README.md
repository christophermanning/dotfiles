# Install

    # single command to download, verify, and run
    pushd /tmp && \
    wget https://raw.githubusercontent.com/christophermanning/dotfiles/master/install.sh && \
    chmod u+x install.sh && \
    sha=$(sha256sum install.sh | cut -f1 -d' ') && \
    [ "$sha" = "d8827d7d040278a0c53e3f5ff7c9dec4f5263d336be7a9c733173e5a9dfe072a" ] && \
    ./install.sh &&\
    popd
