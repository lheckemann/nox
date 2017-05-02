with import <nixpkgs> { };

let
  # Beautiful hacks. Don't look.
  version =
    let
      versionMarker = "version = ";
      setupCfg = builtins.readFile ./setup.cfg;
      lines = lib.splitString "\n" setupCfg;
      versionLine = head (filter (lib.hasPrefix versionMarker) lines);
    in lib.removePrefix versionMarker versionLine;
in
stdenv.lib.overrideDerivation nox (oldAttrs : {
  src = ./.;
  inherit (version);
  buildInputs = oldAttrs.buildInputs ++ [ git ];
})
