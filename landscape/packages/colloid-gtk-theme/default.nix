{ colloid-gtk-theme
, lib
, themeVariants ? [] # default: blue
, colorVariants ? [] # default: all
, sizeVariants ? [] # default: standard
, ...
}:
let
    tweaks = ["everforest" "black" "normal"];
in
colloid-gtk-theme.overrideAttrs (oldAttrs: {

  installPhase = ''
    runHook preInstall

    name= HOME="$TMPDIR" ./install.sh \
      ${lib.optionalString (themeVariants != []) "--theme " + builtins.toString themeVariants} \
      ${lib.optionalString (colorVariants != []) "--color " + builtins.toString colorVariants} \
      ${lib.optionalString (sizeVariants != []) "--size " + builtins.toString sizeVariants} \
      ${lib.optionalString (tweaks != []) "--tweaks " + builtins.toString tweaks} \
      --dest $out/share/themes

    jdupes --quiet --link-soft --recurse $out/share

    runHook postInstall
  '';
})
