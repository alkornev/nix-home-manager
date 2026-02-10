{ ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = { vim = "nvim" };

    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "git" 
        "sudo" 
      ];
      theme = "robbyrussell";
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
  };
}

