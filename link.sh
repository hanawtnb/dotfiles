#!/bin/bash

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# .??* で始まるドットファイルをループ処理
for dotfile in "${DOTFILES_DIR}"/.??* ; do
    # .git, .github, .DS_Store は除外
    [[ "$dotfile" == "${DOTFILES_DIR}/.git" ]] && continue
    [[ "$dotfile" == "${DOTFILES_DIR}/.github" ]] && continue
    [[ "$dotfile" == "${DOTFILES_DIR}/.DS_Store" ]] && continue

    # 他のファイルは $HOME にリンク
    ln -fnsv "$dotfile" "$HOME"
done

# alacritty/alacritty.toml を ~/.config/alacritty/ にリンク
ALACRITTY_CONFIG="$DOTFILES_DIR/alacritty/alacritty.toml"
if [[ -f "$ALACRITTY_CONFIG" ]]; then
    mkdir -p "$HOME/.config/alacritty"
    ln -fnsv "$ALACRITTY_CONFIG" "$HOME/.config/alacritty/alacritty.toml"
fi
