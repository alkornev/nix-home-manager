{
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    initLua = ''
      vim.g.editorconfig = true
      vim.opt.number = true
      vim.opt.relativenumber = true
    '';
  };
}
