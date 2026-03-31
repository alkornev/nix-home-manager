{ pkgs, ... }:
{
  home.packages = [ pkgs.ollama ];

  systemd.user.services.ollama = {
    Unit = {
      Description = "Ollama LLM server";
      After = [ "network.target" ];
    };

    Service = {
      ExecStart = "${pkgs.ollama}/bin/ollama serve";
      Restart = "on-failure";
      RestartSec = 3;
      # Optional: set models directory
      Environment = [
        "OLLAMA_MODELS=%h/.ollama/models"
        "HOME=%h"
      ];
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
