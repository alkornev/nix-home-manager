{ lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000000;
      save = 10000000;
      path = "$HOME/.cache/zsh/zhistory";
      share = true;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      ignoreAllDups = true;
      findNoDups = true;
      saveNoDups = true;
      # findDups = true;
      ignoreSpace = true;
      extended = true;
    };

    historySubstringSearch.enable = true;

    shellAliases = {
      ll = "ls -la";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "fzf"
        "docker"
        "docker-compose"
        "podman"
        "pip"
      ];
    };
    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-syntax-highlighting"
        "zsh-users/zsh-history-substring-search"
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-completions"
      ];
    };
    initContent = lib.mkMerge [
      (lib.mkBefore ''
        # oh-my-zsh docker plugin copies from Nix store (0444), making the cache read-only.
        # Make it writable before plugins load so it can be overwritten each time.
        chmod u+w "$HOME/.cache/oh-my-zsh/completions/_docker" 2>/dev/null || true
      '')
      ''
        # Additional history options not covered by Home Manager
        setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording entry.
        setopt HIST_VERIFY            # Don't execute immediately upon history expansion.
        setopt HIST_BEEP              # Beep when accessing nonexistent history
      ''
    ];
  };
}
