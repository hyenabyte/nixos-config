{ lib
, makeDesktopItem
, firefox
, namespace
, ...
}:
let
  with-meta = lib.${namespace}.override-meta {
    platforms = lib.platforms.linux;
    broken = firefox.meta.broken;

    description = "A desktop item to open Phanpy in Firefox.";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ ];
  };

  phanpy = makeDesktopItem {
    name = "Phanpy";
    desktopName = "Phanpy";
    genericName = "Phanpy";
    exec = ''${firefox}/bin/firefox "https://phanpy.social/"'';
    icon = ./logo-4.svg;
    type = "Application";
    categories = [
      "Network"
      "InstantMessaging"
      "Feed"
    ];
    terminal = false;
  };
in
with-meta phanpy
