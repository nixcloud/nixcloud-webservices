{ lib }:

rec {
  # Returns a list of the components of the given path.
  splitPath = path: let
    result = builtins.match "([^/]*)/(.*)" path;
    iter = [ (lib.head result) ] ++ splitPath (lib.last result);
  in if result == null then [ path ] else iter;

  # Strips out every component that contains "." or ".." and also strips out
  # unnecessary slashes (eg. "////" becomes "/").
  sanitizePath = path: let
    splitted = splitPath path;
    filtered = lib.filter (c: c != "" && c != "." && c != "..") splitted;
  in lib.concatStringsSep "/" filtered;

  # Turn a permission config (created by mkPermOpts) into short text
  # permission form like eg. "rwx" or "r-x".
  permConfToRWX = isDir: cfg: let
    execAttr = if isDir then "search" else "execute";
    fullBits = if isDir then "rwx" else "rw${execBit}";
    mkBit = val: bit: if val then bit else "-";
    readBit = mkBit cfg.read "r";
    writeBit = mkBit cfg.write "w";
    execBit = mkBit cfg.${execAttr} "x";
  in if cfg.fullAccess then fullBits
     else if cfg.noAccess then "---"
     else readBit + writeBit + execBit;
}
