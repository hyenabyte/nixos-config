{ channels
, ...
}:

final: prev: {
  inherit (channels.unstable) isd;
}
