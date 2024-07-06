{...} @ inputs: filePath: let
  keysFile =
    builtins.readFile filePath;
  keyList = inputs.nixpkgs.lib.strings.splitString "\n" keysFile;
  keys = inputs.nixpkgs.lib.lists.remove "" keyList;
in {
  keys = keys;
}
