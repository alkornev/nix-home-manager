{
  programs.git = {
    enable = true;
    
    settings = {
	user.name = "Aleksei Kornev";
	user.email = "al.a.kornev@gmail.com";
      
	color = {
	  ui = "auto";
	  branch = "auto";
	  diff = "auto";
	  status = "auto";
	};
	
	core = {
	  autocrlf = "input";
	  excludesfile = "~/.config/gitignore_global";
	};
	
	log = {
	  date = "relative";
	};
	
	init = {
	  defaultBranch = "main";
	};
        alias = {

	  ls = "ls-files";
	  b = "branch";
	  br = "branch";
	  bvv = "branch -vv";
	  ba = "branch --all";
	  t = "tag";
	  d = "diff --stat -p -C";
	  ds = "diff --staged --stat -p -C";
	  ci = "commit -v";
	  co = "checkout";
	  st = "status -sb";
	  pr = "pull --rebase";
	  wc = "whatchanged --abbrev-commit --date=relative --date-order --pretty='format:%Cgreen%h %Cblue%ar %Redby %an%Creset -- %s' -n 45";
	  l = "log -p";
	  ll = "log --decorate --graph --pretty=format:'%Cred%h%Creset %<(50,trunc)%s %Cgreen%cr%C(auto)%d %C(cyan)<%an>'";
	  lla = "ll --all";
	  gl = "log --decorate --graph --abbrev-commit --color --color-words --topo-order --pretty=medium";
	  gla = "gl --all";
	  sl = "log --decorate --graph --abbrev-commit --color --topo-order --pretty=oneline";
	  sla = "sl --all";
	};
      };	
    };
}
