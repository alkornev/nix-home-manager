{ lib, pkgs, ... }: let 
  username = "aalkornev";
in {
  home = {
    packages = with pkgs; [
      hello
      home-manager
      htop
      feh
    ];
    
    inherit username; 
    homeDirectory = "/home/${username}";
   
    stateVersion = "25.11";
  };

  programs.git = {
    enable = true;
    settings.user.name = "Aleksei Kornev";
    settings.user.email = "al.a.kornev@gmail.com";
  };
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
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

  programs.vim = {
    enable = true;

    settings = {
      relativenumber = true;
    };
    
    plugins = with pkgs.vimPlugins; [
      vim-nix
    ];
    
    extraConfig = ''
      syntax on
    '';
  };
}
