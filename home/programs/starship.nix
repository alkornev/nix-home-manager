{ lib, ... }:
{
  programs.starship = {
    enable = true;

    settings = {
      format = lib.concatStrings [
        "$\{custom.visual_divider\}"
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
        "$docker_context$character"
      ];

      custom.visual_divider = {
        command = "echo 🚀";
        when = true;
      };

      directory = {
        truncation_length = 0;
        truncate_to_repo = false;
        truncation_symbol = "../";
        style = "";
      };

      git_branch = {
        truncation_length = 32;
        truncation_symbol = "...";
        format = "[$symbol$branch]($style) ";
      };

      cmd_duration = {
        min_time = 0;
        style = "bold yellow";
        format = "[$duration]($style) ";
        show_milliseconds = true;
      };

      status = {
        format = "[\\[$status\\]]($style) ";
        disabled = false;
        recognize_signal_code = true;
      };

      python = {
        style = "bold purple";
        python_binary = [
          "python3"
          "python"
        ];
        detect_env_vars = [ "PATH" ];
      };

      time = {
        disabled = false;
        format = "[\\[$time\\]]($style) ";
        time_format = "%T";
        style = "yellow";
      };
    };
  };
}
