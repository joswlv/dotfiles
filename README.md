# dotfiles

macOS 개발 환경 자동화 dotfiles

## Quick Start (새 Mac 설정)

```bash
# 1. Clone & Install (한 줄로 완료)
git clone https://github.com/joswlv/dotfiles.git ~/dotfiles && cd ~/dotfiles && ./install.sh

# 또는 curl로 직접 실행
curl -fsSL https://raw.githubusercontent.com/joswlv/dotfiles/master/install.sh | bash
```

설치 스크립트가 자동으로 처리하는 것들:
- Xcode CLI Tools
- Homebrew + 모든 패키지 (Brewfile)
- Oh My Zsh + 플러그인
- Vim + vim-plug + 플러그인
- SDKMAN
- FZF
- symlink 생성
- macOS 기본 설정 (선택)

## 설치 후 필수 작업

```bash
# 1. 로컬 설정 파일 편집 (API 키, 시크릿 등)
vim ~/.zshrc.local

# 2. SDKMAN으로 Java 설치
sdk install java 17.0.9-tem

# 3. 터미널 재시작 또는
source ~/.zshrc
```

## 명령어

```bash
make help       # 도움말
make deploy     # symlink 생성
make update     # git pull + 재배포
make sync       # 현재 brew 패키지를 Brewfile에 동기화
make brew       # Brewfile 패키지 설치
make vim        # Vim 플러그인 설치/업데이트
make test       # 설치 상태 확인
make backup     # 기존 설정 백업
make clean      # symlink 제거
```

## 구조

```
~/dotfiles/
├── .zshrc                 # ZSH 설정 (공개)
├── .zshrc.local.example   # 로컬 설정 템플릿 (시크릿용)
├── .vimrc                 # Vim 설정 (vim-plug)
├── .gitconfig             # Git 설정 + aliases
├── .gitignore             # Global gitignore
├── Brewfile               # Homebrew 패키지 목록
├── Makefile               # 관리 명령어
├── install.sh             # 자동 설치 스크립트
├── bin/                   # 커스텀 스크립트
└── intellij/              # IntelliJ 설정 (키맵, 플러그인 목록)
```

## 주요 설정

### ZSH
- Oh My Zsh + robbyrussell 테마
- 플러그인: git, zsh-fzf-history-search
- Homebrew 플러그인: syntax-highlighting, autosuggestions, history-substring-search
- arm64/x86 자동 감지

### Vim
- vim-plug (플러그인 자동 설치)
- NERDTree, CtrlP, ALE, vim-fugitive
- jellybeans/dracula 테마

### Git Aliases
```bash
git l          # 로그 그래프
git bb         # 브랜치 선택 (fzf)
git a          # 파일 선택 후 add (fzf)
git stash-pop  # stash 선택 후 pop (fzf)
```

### IntelliJ IDEA

**권장: JetBrains Settings Sync 사용**
1. `Settings` > `Settings Sync` > `Enable Settings Sync`
2. JetBrains 계정으로 로그인하면 자동 동기화

**수동 설정 (키맵 복사):**
```bash
cp ~/dotfiles/intellij/*.xml \
   ~/Library/Application\ Support/JetBrains/IntelliJIdea2025.2/keymaps/
```

플러그인 목록: `intellij/plugins.txt` 참고

## 시크릿 관리

**절대 `.zshrc`에 API 키를 넣지 마세요!**

`~/.zshrc.local`에 저장 (git에서 제외됨):

```bash
# ~/.zshrc.local
export OPENAI_API_KEY="sk-..."
export AWS_CA_BUNDLE="/path/to/ca-bundle.pem"
```

## 패키지 동기화

```bash
# 현재 설치된 brew 패키지를 Brewfile에 저장
make sync

# 변경사항 확인 후 커밋
cd ~/dotfiles && git diff
git add Brewfile && git commit -m "Update Brewfile"
```

## 문제 해결

### Vim 플러그인 문제
```bash
# 플러그인 재설치
make vim

# 또는 vim 내에서
:PlugInstall
:PlugUpdate
:PlugClean
```

### ZSH 플러그인 문제
```bash
# fzf-history-search 재설치
git clone https://github.com/joshskidmore/zsh-fzf-history-search.git \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search
```

### symlink 확인
```bash
make test
```
