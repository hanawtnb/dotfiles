if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -Uz compinit
compinit

# -----------------------------------------------------------------------------
#   Plugin list
# -----------------------------------------------------------------------------

zinit light romkatv/powerlevel10k
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light mollifier/anyframe
zinit light mollifier/cd-bookmark
zinit ice lucid depth"1" blockf
zinit light yuki-yano/zeno.zsh

# ---------------------------------------------------------------------------
#        PATH ...
# ---------------------------------------------------------------------------

export PATH="$PATH:/usr/local/bin"
export PATH=/opt/homebrew/bin:$PATH
export ZENO_HOME=~/.config/zeno

# -----------------------------------------------------------------
#      setting....
# -----------------------------------------------------------------

# コマンド履歴の管理ファイル
HISTFILE=~/.zsh_history
# メモリに保存する履歴のサイズ
export HISTSIZE=10000
# ファイルに保存する履歴のサイズ
export SAVEHIST=100000
# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# コマンドのスペルを訂正
setopt correct
# 補完候補を詰めて表示
setopt list_packed
## 他のzshと履歴を共有
setopt inc_append_history
setopt share_history
## パスを直接入力してもcdする
setopt AUTO_CD
# 補完候補をカーソルで選択
zstyle ':completion:*:default' menu select=1
# スラッシュを単語の区切りと見なす
autoload -Uz select-word-style
select-word-style bash
WORDCHARS='.-'
# ヒストリーに重複を表示しない
setopt hist_ignore_all_dups
# 重複するコマンドが保存されるとき、古い方を削除する。
setopt hist_save_no_dups
# コマンドのタイムスタンプをHISTFILEに記録する
setopt extended_history
# HISTFILEのサイズがHISTSIZEを超える場合、最初に重複を削除
setopt hist_expire_dups_first
# コマンドラインでも # 以降をコメントと見なす
setopt interactive_comments
# LSDで使用されるカラーを変更(ディレクトリのみ変更)
export LS_COLORS="di=36"
# cd抜きでもパスと認識されればcd
setopt AUTO_CD

# ----------------------------
# alias
# ----------------------------
# zeno-snippet > ~/.config/zeno/config.yml

alias g="git"
alias gb="git branch"
alias gsw="git switch"
alias gco="git checkout"
alias gcmsg='git commit -m'
alias gcm='git checkout master'
alias gl='git pull'
alias gp='git push'
alias ga='git add'

alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

alias tp='cd-bookmark'

alias dcb="docker-compose build"
alias dcu="docker-compose up -d"
alias dcd="docker-compose down"
alias dce="docker-compose exec"
alias dcps="docker-compose ps"

alias sz="source ~/.zshrc"


# -----------------------------
#  Anyframe bindkey
# -----------------------------
# color config > ~/.config/peco/config.json

# ディレクトリの移動履歴を表示
bindkey '^]' anyframe-widget-cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# コマンドの実行履歴を表示
bindkey '^R' anyframe-widget-execute-history

# Gitブランチを表示して切替え
bindkey '^x^b' anyframe-widget-checkout-git-branch


# -----------------------------
#  zeno setting
# -----------------------------
if [[ -n $ZENO_LOADED ]]; then
  bindkey ' '  zeno-auto-snippet
  bindkey '^x' zeno-insert-snippet
  bindkey '^g' zeno-ghq-cd
fi
