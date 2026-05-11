{ pkgs, ... }:
{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    stdenv.cc.cc.lib

    zlib
    zstd
    xz
    bzip2

    openssl
    curl
    libssh

    expat
    libxml2
    libxslt

    libgcrypt
    libgpg-error
    libsodium

    libffi
    libuuid

    libusb1
    libpcap

    libcap
    libcap_ng

    libsecret
    libnotify

    libdrm
    libgbm
    libGL
    libglvnd
    mesa

    vulkan-loader

    cudaPackages.cuda_cudart
    cudaPackages.cudnn

    ffmpeg

    alsa-lib
    pipewire
    pulseaudio

    fuse
    fuse3

    dbus
    systemd
    util-linux
    e2fsprogs

    krb5
    keyutils

    nspr
    nss

    cairo
    pango
    gdk-pixbuf
    glib
    gtk3
    atk
    at-spi2-atk
    at-spi2-core

    cups

    gobject-introspection

    freetype
    fontconfig
    harfbuzz
    icu

    libx11
    libxcomposite
    libxcursor
    libxdamage
    libxext
    libxfixes
    libxi
    libxrandr
    libxrender
    libxscrnsaver
    libxtst
    libxcb
    libxkbfile
    libxshmfence
    libxxf86vm
    libxcb-util
    libxcb-image
    libxcb-keysyms
    libxcb-render-util
    libxcb-wm

    libxkbcommon
    wayland

    sqlite
    readline
    ncurses

    tbb
    gmp
    mpfr
  ];
}
