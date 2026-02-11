{
  programs.neovim = {
    enable = true;

    extraLuaConfig = ''
      vim.g.editorconfig = true
      vim.opt.number = true
      vim.opt.relativenumber = true
    '';
  };
}
