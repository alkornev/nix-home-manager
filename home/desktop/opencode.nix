{ ... }:
{
  home.file.".config/opencode/opencode.json".text = builtins.toJSON {
    "$schema" = "https://opencode.ai/config.json";
    autoupdate = false;
    provider = {
      ollama = {
        npm = "@ai-sdk/openai-compatible";
        name = "Ollama (local)";
        options = {
          baseURL = "http://localhost:11434/v1";
        };
        models = {
          "qwen3-coder:30b-a3b-q4_K_M" = {
            name = "Qwen3 Coder 30B (Q4)";
          };
          "qwen2.5-coder:7b" = {
            name = "Qwen2.5 Coder 7B";
          };
        };
      };
    };
  };
}
