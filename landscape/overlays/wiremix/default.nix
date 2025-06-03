{ inputs
, ...
}:

final: prev: {
  wiremix = inputs.wiremix.packages.${prev.system}.default;
}
