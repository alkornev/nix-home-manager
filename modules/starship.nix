{ lib, ... }: 
{
  programs.starship = {
    enable = true;
    
    settings = {
      format = lib.concatStrings [
        "${custom.visual_divider}"
	"$jobs"
        "$cmd_duration"
        "$status"
	"$python"
	"$line_break"
        "$time"
	"$directory"
	"$git_branch"
	"$git_commit"
	"$git_state"
	"$git_status"
	"$line_break"
      ];

      custom.visual_divider = {
        command = "echo Rocket";
	when = true;
      };

    };
  };
}
