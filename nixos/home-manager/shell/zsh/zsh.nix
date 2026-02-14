{
  pkgs,
  profile,
  lib,
  config,
  ...
}:

{
  # Install base visual tools
  home.packages = [ pkgs.pfetch ];

  # Import modular shell components
  imports = [
    ./functions.nix
    ./aliases.nix
  ];

  # Prompt configuration
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    useTheme = "catppuccin_frappe";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;

    # ---------- History Settings ----------
    history = {
      path = "${config.home.homeDirectory}/.zsh_history";
      size = 10000;
      save = 10000;
      ignoreAllDups = true;
      share = true;
    };

    # ---------- Zsh Shell Options ----------
    setOptions = [
      "HIST_IGNORE_ALL_DUPS"
      "SHARE_HISTORY"
      "AUTO_CD"
      "HIST_REDUCE_BLANKS"
    ];

    # ---------- Session Variables ----------
    sessionVariables = {
      PATH = "$HOME/.local/bin:$PATH:/sbin";
      WORDCHARS = "*?_-.[]~&;!#$%^(){}<>";
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "fg=#6c7086";
      LS_COLORS = "di=0:ln=36:ex=1;32:*.tar=31:*.zip=31:*.gz=31";
    };

    # ---------- Completion Optimization ----------
    completionInit = ''
      # Fast compinit loading using cache
      autoload -Uz compinit
      setopt EXTENDEDGLOB
      for dump in $HOME/.zcompdump(#qN.m1); do
        compinit -C
      done
      compinit -C

      # Completion styling
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
    '';

    # ---------- Main Logic (Keybindings + Zinit) ----------
    initContent = lib.mkMerge [
      (lib.mkBefore ''
        # Automatic Zinit installation
        ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
        if [[ ! -f $ZINIT_HOME/zinit.zsh ]]; then
            print -P "%F{33} Installing Zinit...%f"
            command mkdir -p "$(dirname $ZINIT_HOME)"
            command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
        fi
        source "$ZINIT_HOME/zinit.zsh"

        # Plugins in Turbo Mode (Non-blocking startup)
        zinit wait"0a" lucid light-mode for \
            atload"_zsh_autosuggest_start" \
                zsh-users/zsh-autosuggestions \
            atinit"zicompinit; zicdreplay" \
                zdharma-continuum/fast-syntax-highlighting

        # Syntax highlighting styles
        typeset -gA FAST_HIGHLIGHT_STYLES
        FAST_HIGHLIGHT_STYLES[path]='none'
      '')

      ''
        # Emacs-style keybindings
        bindkey -e
        bindkey '^A' beginning-of-line
        bindkey '^E' end-of-line
        bindkey '^[b' backward-word
        bindkey '^[f' forward-word
        bindkey '^[[1;5D' backward-word
        bindkey '^[[1;5C' forward-word
        bindkey '^[^?' backward-kill-word

        # Intelligent history search with arrow keys
        autoload -U history-search-end
        zle -N history-beginning-search-backward-end history-search-end
        zle -N history-beginning-search-forward-end history-search-end
        bindkey '^[[A' history-beginning-search-backward-end
        bindkey '^[[B' history-beginning-search-forward-end

        # Terminal cleanup
        stty stop undef 2>/dev/null

        # Display system information on every startup
        pfetch
      ''
    ];
  };
}
