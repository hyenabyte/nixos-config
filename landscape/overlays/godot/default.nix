{ channels
, ...
}:

final: prev: {
  inherit (channels.unstable) godot;
}
