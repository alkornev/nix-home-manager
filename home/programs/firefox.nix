{ pkgs, config, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-bin;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
    profiles.default.settings = {
      "mousewheel.min_line_scroll_amount" = 40;
      "general.smoothScroll.mouseWheel.durationMaxMS" = 200;
      "general.smoothScroll.mouseWheel.durationMinMS" = 100;

      "media.ffmpeg.vaapi.enabled" = true;
      "media.rdd-ffmpeg.enabled" = true;
      "media.hardware-video-decoding.force-enabled" = true;
      "widget.dmabuf.force-enabled" = true;
    };
  };
}
