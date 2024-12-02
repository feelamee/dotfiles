if command -v helix &>/dev/null
    set hx helix
else
    set hx hx
end

export EDITOR="$hx"
export VISUAL="$hx"
export PAGER="bat --style=plain"

alias ya=yazi

export XDG_CONFIG_HOME="$(xdg-user-dir CONFIG)"
export XDG_DATA_HOME="$(xdg-user-dir DATA)"
export XDG_STATE_HOME="$(xdg-user-dir STATE)"
export XDG_CACHE_HOME="$(xdg-user-dir CACHE)"

export HISTFILE="$XDG_STATE_HOME/bash/history"
export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"

export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

export CARGO_HOME="$XDG_DATA_HOME/cargo"

export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

export VIMINIT="source $XDG_CONFIG_HOME/vim/vimrc"

export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"

export WINEPREFIX="$XDG_DATA_HOME/wine"

export ANDROID_USER_HOME="$XDG_DATA_HOME/android"
function adb
    set HOME "$ANDROID_USER_HOME"
    command adb $argv
end

export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

export XCURSOR_PATH="/usr/share/icons:$XDG_DATA_HOME/icons"

export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java -Djavafx.cachedir=$XDG_CACHE_HOME/openjfx"

export REDISCLI_HISTFILE="$XDG_STATE_HOME/redis/rediscli_history"

export W3M_DIR="$XDG_DATA_HOME"/w3m

export XMAKE_PKG_INSTALLDIR="$XDG_DATA_HOME"/xmake
export XMAKE_PKG_CACHEDIR="$XDG_CACHE_HOME"/xmake
export XMAKE_GLOBALDIR="$XDG_CONFIG_HOME"/xmake

export CONAN_HOME="$XDG_DATA_HOME/conan2"

export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

export VCACHE="$XDG_CACHE_HOME/vlang"

export SVN_CONFIG_DIR="$XDG_CONFIG_HOME/subversion"

function svn
    command svn --config-dir "$SVN_CONFIG_DIR" $argv
end

export FZF_DEFAULT_OPTS="
    --multi
    --color=fg:#908caa,bg:#232136,hl:#ea9a97
    --color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
    --color=border:#44415a,header:#3e8fb0,gutter:#232136
    --color=spinner:#f6c177,info:#9ccfd8,separator:#44415a
    --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
    --bind=ctrl-f:preview-down
    --bind=ctrl-b:preview-up"

export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/ripgrep/config"

export GOPATH="$XDG_DATA_HOME"/go

alias hx=$hx

zoxide init fish | source
direnv hook fish | source
set -g direnv_fish_mode disable_arrow
jj util completion fish | source
git lfs completion fish | source
