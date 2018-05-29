#!/usr/bin/env bash
install_on_my_zsh() {
  echo "Setting up zsh..." \
  && rm -rf ~/.zshrc ~/.oh-my-zsh \
  && sudo apt-get install zsh \
  && ln -s $(pwd)/zshrc ~/.zshrc \
  && git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
  && chsh -s /bin/zsh \
  && git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions \
  && git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search \
  && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
  && mkdir -p ~/.oh-my-zsh/custom/themes \
  && ln -s $(pwd)/cloud_kris.zsh-theme ~/.oh-my-zsh/custom/themes \
  && rm -f ~/z.sh \
  && curl -fLo ~/z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh
}

setup_tmux() {
  echo "Setting up tmux..." \
  && sudo apt-get install tmux \
  && rm -rf ~/.tmux.conf ~/.tmux .tmux \
  && git clone https://github.com/gpakosz/.tmux.git \
  && ln -s -f .tmux/.tmux.conf \
  && cp .tmux/.tmux.conf.local ~ 
}

install_fzf() {
  echo "Installing fzf..." \
  && rm -rf ~/.fzf \
  && git clone https://github.com/junegunn/fzf ~/.fzf \
  && ~/.fzf/install --all
}

setup_neovim() {
  echo "Setting up neovim..." \
  && sudo apt-get install software-properties-common \
  && sudo apt-add-repository ppa:neovim-ppa/stable \
  && sudo apt-get update \
  && sudo apt-get install neovim \
  && sudo apt-get install python-dev python-pip python3-dev python3-pip \
  && rm -rf ~/.config/nvim ~/.vim \
  && mkdir -p ~/.config \
  && git clone https://github.com/rafi/vim-config.git ~/.config/nvim \
  && ln -s ~/.config/nvim ~/.vim \
  && pip install --user --upgrade PyYAML \
  && pip install virtualenv \
  && sudo apt-get install python3-venv \
  && cd ~/.config/nvim \
  && rm -rf ~/.cache/vim \
  && ./venv.sh \
  && make test \
  && make \
  && rm -rf ~/.nvm \
  && git clone https://github.com/creationix/nvm.git ~/.nvm \
  && wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | zsh \
  && source ~/.zshrc \
  && nvm install node \
  && npm -g install jshint jsxhint jsonlint stylelint sass-lint \
  && npm -g install raml-cop markdownlint-cli write-good \
  && pip install --user pycodestyle pyflakes flake8 vim-vint proselint yamllint \
  && npm -g install tern \
  && cd ~/neovim-config
}

install_fonts() {
  echo "Setting up fonts..." \
  && mkdir -p ~/.fonts \
  && rm -rf ~/.fonts/iosevka-* \
  && cp $(pwd)/fonts/* ~/.fonts/
}

install_ripgrep() {
  echo "Installing ripgrep..." \
  && sudo rm -f /usr/local/bin/rg \
  && curl -L https://github.com/BurntSushi/ripgrep/releases/download/0.8.1/ripgrep-0.8.1-x86_64-unknown-linux-musl.tar.gz | tar zx \
  && sudo cp ripgrep-0.8.1-x86_64-unknown-linux-musl/rg /usr/local/bin \
  && rm -rf ripgrep-0.8.1-x86_64-unknown-linux-musl
}

install_ctags() {
  local ctags_installed=$(which ctags)
  if [[ -z $ctags_installed ]]; then
    echo "Installing universal ctags..." \
    && rm -rf ./ctags \
    && git clone https://github.com/universal-ctags/ctags \
    && sudo apt-get install -y pkg-config \
    && cd ctags && ./autogen.sh && ./configure && make && sudo make install && cd ../ && rm -rf ctags
  fi
}

install_diff_so_fancy() {
  local dif_so_fancy_installed=$(which diff-so-fancy)
  if [[ -z $dif_so_fancy_installed ]]; then
    echo "Installing diff-so-fancy..." \
    && npm install -g diff-so-fancy \
    && git config --global core.pager "diff-so-fancy | less --tabs=4 -R"
  fi
}

echo -n "This will delete all your previous nvim, tmux and zsh settings. Proceed? (y/n)? "
read answer
if echo "$answer" | grep -iq "^y" ;then
  echo "Installing dependencies..." \
  && sudo apt-get install urlview xdotool dh-autoreconf dconf-cli \
  && install_on_my_zsh \
  && setup_tmux \
  && setup_neovim \
  && install_fzf \
  && install_fonts \
  && install_ripgrep \
  && install_ctags \
  && echo "Finished installation."
fi
