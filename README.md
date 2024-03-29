dotfiles로 iTerm2 + zsh + vim + Git 설치/설정 자동화하기
---------------
zsh와 tmux, vim 설치 및 설정을 자동화해서 편하게 맥에서 환경을 구축할 수 있게 해준다. 그리고 수정, 개선사항은 github의 [dotfiles][git_dotfiles] 리파지토리에 관리하면 로컬 맥에서 .dotfiles에서 `make update` 명령어만 날리면 로컬 환경에 자동 반영된다.

brew 추가할 내용은 `dotfiles/etc/init/assets/brew/Brewfile`에 하면 된다.
```
$ git clone https://github.com/joswlv/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles && make install
$ vim +NeoBundleInit +qall # Vim 플러그인 설치
$ chsh -s /bin/zsh # zsh 설정
$ git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
$ git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
$ git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```


### 1. 커맨드 관련 편리한 기능들
```
$ cd - Enter : 과거 커맨드 중복 제거된 히스토리 보여줌
$ cd Enter   : 현재창에서 과거에 입력한 커맨드 보여줌.
```

### 2. zshrc 설정 정보
```
$ .. : "cd .."와 동일. 이전 데릭토리로 갈 리스트 보여줌.
$ cd - Enter : 과거 커맨드 중복 제거된 히스토리 보여줌
$ cd Enter : 과거에 입력한 커맨드 보여줌.

# alias -g C='| pbcopy'
$ cat ~/.ssh/id_rsa.pub C : "cat ~/.ssh/id_rsa.pub | pbcopy"와 동일한 명령어로 id_rsa.pub의 내용을 클립보드에 복사.
```

### 3. Vim 설정 정보
```
VundleVim설치
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

:PluginInstall
```
### 4. 추가 설치 app
- sequel pro
- DBeaver enterprise 4.0.4
- MacDown
- GasMask
- spectacle
- winarchiver lite
- feedly
- [karabiner](https://pqrs.org/osx/karabiner/) - for HHKB

### 5. iterm triggers설정
```
(?i:.*error|Error|ERROR.*) 
(?i:.*(warning|warn).*)
(?i:.*FATAL.*)
```

### 6. vscode extension
```
code --install-extension adpyke.vscode-sql-formatter
code --install-extension CJamesMay.plush
code --install-extension CoenraadS.bracket-pair-colorizer-2
code --install-extension dvirtz.parquet-viewer
code --install-extension GitHub.copilot
code --install-extension golang.go
code --install-extension golang.go-nightly
code --install-extension GrapeCity.gc-excelviewer
code --install-extension mhutchie.git-graph
code --install-extension ms-azuretools.vscode-docker
code --install-extension ms-python.python
code --install-extension ms-python.vscode-pylance
code --install-extension ms-toolsai.jupyter
code --install-extension ms-toolsai.jupyter-keymap
code --install-extension ms-toolsai.jupyter-renderers
code --install-extension oboki.sql-styler
code --install-extension premparihar.gotestexplorer
code --install-extension quillaja.goasm
code --install-extension scala-lang.scala
code --install-extension windmilleng.vscode-go-autotest
```

참고 링크 : http://blog.appkr.kr/work-n-play/dotfiles/

[mac_terminal]: http://i.imgur.com/sDxus3j.png
[git_dotfiles]: https://github.com/mimul/dotfiles
