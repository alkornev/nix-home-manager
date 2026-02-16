{pkgs, ... }:
{
  programs.firefox= {
    enable = true;
    package = pkgs.firefox-bin;
    profiles.default.settings = {
      "mousewheel.min_line_scroll_amount" = 40;
      "general.smoothScroll.mouseWheel.durationMaxMS" = 200;
      "general.smoothScroll.mouseWheel.durationMinMS" = 100;
    };
  };
}
