{ colloid-icon-theme
, lib
, ...
}:
let
  schemeVariants = [ "everforest" ];
  colorVariants = [ ];
in
colloid-icon-theme.overrideAttrs (oldAttrs: {

  installPhase = ''
    runHook preInstall

    name= ./install.sh \
      ${lib.optionalString (schemeVariants != []) ("--scheme " + builtins.toString schemeVariants)} \
      ${lib.optionalString (colorVariants != []) ("--theme " + builtins.toString colorVariants)} \
      --dest $out/share/icons

    jdupes --quiet --link-soft --recurse $out/share

    runHook postInstall
  '';
})
