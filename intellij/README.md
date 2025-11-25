# IntelliJ IDEA 설정

## 권장: JetBrains Settings Sync (가장 간편)

1. IntelliJ 실행
2. `Settings` > `Settings Sync` > `Enable Settings Sync`
3. JetBrains 계정으로 로그인
4. 동기화할 항목 선택 (keymaps, plugins, settings 등)

새 Mac에서 같은 계정으로 로그인하면 자동 복원됨.

---

## 수동 설정 (dotfiles 사용)

### 키맵 복사

```bash
# dotfiles에서 IntelliJ로 복사
cp ~/dotfiles/intellij/*.xml \
   ~/Library/Application\ Support/JetBrains/IntelliJIdea2025.2/keymaps/
```

### 커스텀 단축키

| 기능 | 단축키 |
|------|--------|
| Terminal | `⌥T` |
| Recent Projects | `⌃⌥P` |
| Big Data Tools | `⇧⌃⌘B` |

### 플러그인 설치

`plugins.txt` 참고하여 Marketplace에서 설치:

**필수:**
- Scala, Spring, Go, Python
- Rainbow Brackets
- Maven Helper
- Big Data Tools

**추천:**
- Claude Code
- Translation
- JIRA Branch Creator

---

## 설정 백업

```bash
# 현재 키맵을 dotfiles에 백업
cp ~/Library/Application\ Support/JetBrains/IntelliJIdea*/keymaps/*.xml \
   ~/dotfiles/intellij/
```
