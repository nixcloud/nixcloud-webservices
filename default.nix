# This is only an alias for the main modules entry-point and it will be
# replaced during channel creation. So if you ever need change anything in this
# file, be sure to modify channel creation in release.nix as well.
{ imports = [ ./modules ]; }
