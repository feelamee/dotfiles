if command -q helix
    alias hx=helix
end

if command -q nvim
   export EDITOR="nvim"
   export VISUAL="nvim"
else if command -q vim
    export EDITOR="vim"
    export VISUAL="vim"
else if command -q vi
    export EDITOR="vi"
    export VISUAL="vi"
end

if not command -q nvim
    export VIMINIT="source $XDG_CONFIG_HOME/vim/vimrc"
end

if command -q bat
    export PAGER="bat"
else
    export PAGER="less --RAW-CONTROL-CHARS"
end

if command -q yazi
    alias ya=yazi
end

export XDG_CONFIG_HOME="$(xdg-user-dir CONFIG)"
export XDG_DATA_HOME="$(xdg-user-dir DATA)"
export XDG_STATE_HOME="$(xdg-user-dir STATE)"
export XDG_CACHE_HOME="$(xdg-user-dir CACHE)"

export HISTFILE="$XDG_STATE_HOME/bash/history"
export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"

export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

export CARGO_HOME="$XDG_DATA_HOME/cargo"

export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

export PASSWORD_STORE_DIR="$XDG_DATA_HOME/pass"

export WINEPREFIX="$XDG_DATA_HOME/wine"

export ANDROID_USER_HOME="$XDG_DATA_HOME/android"

if command -q adb
    function adb
        set HOME "$ANDROID_USER_HOME"
        command adb $argv
    end
end

export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

export XCURSOR_PATH="/usr/share/icons:$XDG_DATA_HOME/icons"

export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java -Djavafx.cachedir=$XDG_CACHE_HOME/openjfx"
export JAVA_HOME="/usr/lib/jvm/default"

export REDISCLI_HISTFILE="$XDG_STATE_HOME/redis/rediscli_history"

export W3M_DIR="$XDG_DATA_HOME"/w3m

export XMAKE_PKG_INSTALLDIR="$XDG_DATA_HOME"/xmake
export XMAKE_PKG_CACHEDIR="$XDG_CACHE_HOME"/xmake
export XMAKE_GLOBALDIR="$XDG_CONFIG_HOME"/xmake

export CONAN_HOME="$XDG_DATA_HOME/conan2"

export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"

export VCACHE="$XDG_CACHE_HOME/vlang"

export SVN_CONFIG_DIR="$XDG_CONFIG_HOME/subversion"

if command -q svn
    function svn
        command svn --config-dir "$SVN_CONFIG_DIR" $argv
    end
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

export STEAM_FORCE_DESKTOPUI_SCALING=1.5

export CPM_SOURCE_CACHE="$XDG_CACHE_HOME/CPM"

alias wget="wget --hsts-file=\"$XDG_DATA_HOME/wget-hsts\""

if command -q zoxide
    zoxide init fish | source
end

if command -q direnv
    direnv hook fish | source
    set -g direnv_fish_mode disable_arrow
end

if command -q jj
    jj util completion fish | source
end

if command -q git-lfs
    git lfs completion fish | source
end

if command -q ffmpeg
    alias ffmpeg 'ffmpeg -hide_banner'
end

if command -q ffprobe
    alias ffprobe 'ffprobe -hide_banner'
end

################################################################################

export PULSE_SERVER=/tmp/pipewire.socket

