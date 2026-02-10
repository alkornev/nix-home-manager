{ lib, ... }: 
{
  programs.starship = {
    enable = true;
    
    settings = {
      format = lib.concatStrings [
        "status"
	"$line_break"
	"$python"
        "$time"
	"$directory"
	"$git_branch"
	"$git_commit"
	"$git_state"
	"$git_status"
	"$line_break"
      ];
    };
  };
}
