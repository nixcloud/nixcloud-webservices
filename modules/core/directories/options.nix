{ config, lib, isWebServices ? false, basePath ? null, basePathOpt ? null }:

assert isWebServices -> basePath != null && basePathOpt != null;

let
  inherit (lib) types;
  inherit (import ./lib.nix { inherit lib; }) sanitizePath;

  # Only needed if isWebServices is true.
  inherit (config._module.args) mkUnique;

  mkPermOpts = { descCan, descHas, descIsDenied, isDir
               , read ? true, write ? true, execute ? true
               }: let
    extraDesc = lib.optionalString (!isDir) ''
      These permissions are set only for <emphasis>files</emphasis> and not
      directories and are only set/changed during startup
      <emphasis>and</emphasis> whenever <option>recursive</option> is set to
      <literal>true</literal> on a specific directory.
    '';
    dirOrFile = if isDir then "directory" else "file";
    execAttr = if isDir then "search" else "execute";
    andOpt = values: let
      mkOpt = opt: "<option>${opt}</option>";
      left = lib.concatMapStringsSep ", " mkOpt (lib.init values);
      right = mkOpt (lib.last values);
      xAnd = lib.optionalString (lib.length values > 1) "${left} and ";
    in lib.optionalString (values != []) (xAnd + right);
    attrsInvolved = [ "read" "write" ] ++ lib.optional isDir execAttr;
  in {
    read = lib.mkOption {
      type = types.bool;
      default = read;
      example = !read;
      description = ''
        Whether ${descCan} read the contents of the ${dirOrFile}.
      '' + extraDesc;
    };

    write = lib.mkOption {
      type = types.bool;
      default = write;
      example = !write;
      description = (if isDir then ''
        Whether ${descCan} add new entries to the directory.
      '' else ''
        Whether ${descCan} alter the file's contents.
      '') + extraDesc;
    };

    ${execAttr} = lib.mkOption {
      type = types.bool;
      default = execute;
      example = !execute;
      description = (if isDir then ''
        Whether ${descCan} list the contents of the directory.
      '' else ''
        Whether ${descCan} execute the file.
      '') + extraDesc;
    };

    fullAccess = lib.mkOption {
      type = types.bool;
      default = false;
      example = true;
      description = ''
        Whether ${descHas} full access to the ${dirOrFile}, which is a
        short-hand of setting ${andOpt attrsInvolved} to
        <literal>true</literal>.
      '' + extraDesc + ''
        Note that setting this takes precedence over setting any of the
        ${andOpt (attrsInvolved ++ [ "noAccess" ])} options.
      '';
    };

    noAccess = lib.mkOption {
      type = types.bool;
      default = false;
      example = true;
      description = ''
        Whether ${descIsDenied} access to the ${dirOrFile}, which is a
        short-hand of setting ${andOpt [ "read" "write" execAttr ]} to
        <literal>false</literal>.
      '' + extraDesc + ''
        Note that setting this takes precedence over setting any of the
        ${andOpt [ "read" "write" execAttr ]} options.
      '';
    };
  };

  mkDirPermOpts = attrs: {
    filePerms = mkPermOpts (attrs // { isDir = false; execute = false; });
  } // mkPermOpts (attrs // { isDir = true; });

  mkPostCreateUpdateOpt = isUpdate: useRootUser: lib.mkOption {
    type = types.lines;
    default = "";
    example = "echo hello world > test.txt";
    description = let
      userNote = if useRootUser then ''
        <note><para>The command is run as user <systemitem
        class="username">root</systemitem> and group <systemitem
        class="groupname">root</systemitem>.</para></note>
      '' else ''
        <note><para>The command is run as the user specified in
        <option>owner</option> and the group specified in
        <option>group</option>.</para></note>
      '';

      mainDesc = if isUpdate then ''
        Shell commands to run directly after creating the directory and after
        fixing up the permissions on the directory.

        The current working directory for this is set to the directory that is
        to be created or fixed up.
      '' else ''
        Shell commands to run directly after creating the directory. If the
        directory already exists nothing is executed.

        The current working directory for this is set to the newly created
        directory.

        This runs only if <option>create</option> is set to
        <literal>true</literal> (the default) and execution takes place
        ${if useRootUser then "after <option>postCreate</option>"
          else "before <option>postCreateAsRoot</option>"}.
      '';
    in mainDesc + userNote;
  };

in lib.mkOption {
  type = types.attrsOf (types.submodule ({ config, ... }: {
    options = {
      create = lib.mkOption {
        type = types.bool;
        default = true;
        example = false;
        description = "Whether to create the directory during startup.";
      };

      before = lib.mkOption {
        type = types.listOf types.str;
        default = [];
        example = [ "my-shiny.service" ];
        description = ''
          The systemd units which require this directory, so creation or fixup
          should be done prior to the startup of these units.
        '';
      };

      owner = lib.mkOption {
        type = types.str;
        default = "root";
        example = "nobody";
        description = ''
          The owner of the directory which is able to set permissions and ACLs.
        '';
      };

      group = lib.mkOption {
        type = types.str;
        default = "root";
        example = "nogroup";
        description = "The group owning the directory.";
      };

      permissions = {
        enableACLs = lib.mkOption {
          type = types.bool;
          default = true;
          description = ''
            Whether to enable POSIX ACLs for this directory. The default is
            <literal>true</literal> because whenever the file system doesn't
            support POSIX ACLs it will revert to UNIX file permissions.

            It's <emphasis>only</emphasis> useful to disable this if you have a
            service which is checking the group ID bits, because the group IDs
            will be set to the <literal>ACL_MASK</literal> (see <citerefentry>
              <refentrytitle>acl</refentrytitle>
              <manvolnum>2</manvolnum>
            </citerefentry>) value, which causes trouble with some services
            that do not support ACL and thus can't infer the
            <emphasis>effective</emphasis> permissions of the group.

            <note><para>Under the hood, this will still use <citerefentry>
              <refentrytitle>setfacl</refentrytitle>
              <manvolnum>1</manvolnum>
            </citerefentry> but in a way that it will result in ordinary UNIX
            permissions.</para></note>
          '';
        };

        recursive = lib.mkOption {
          type = types.bool;
          default = true;
          example = false;
          description = ''
            Whether to fixup permissions recursively during instance startup.
          '';
        };

        defaultDirectoryMode = lib.mkOption {
          type = lib.mkOptionType {
            name = "file mode bits";
            description = "file mode bits in octal form";
            check = x: let
              modeRegex = "[0-7]?[0-7][0-7][0-7]";
            in types.str.check x && builtins.match modeRegex x != null;
          };
          apply = x: (lib.optionalString (lib.stringLength x == 3) "0") + x;
          default = "0755";
          example = "0711";
          description = ''
            The default mode to use when creating leading directories.

            Leading directories will be owned by user <systemitem
            class="username">root</systemitem> and group <systemitem
            class="groupname">root</systemitem>.

            <note><para>This applies only to <emphasis>leading</emphasis>
            directories, the last component will have the permissions specified
            via the options in this submodule.</para></note>
          '';
        };

        owner = mkDirPermOpts {
          descCan = "the owner can";
          descHas = "the owner has";
          descIsDenied = "the owner is denied";
        };

        group = mkDirPermOpts {
          descCan = "the group can";
          descHas = "the group has";
          descIsDenied = "the group is denied";
          write = false;
        };

        others = mkDirPermOpts {
          descCan = "others can";
          descHas = "others have";
          descIsDenied = "others are denied";
          write = false;
        };

        dirMask = mkPermOpts {
          descCan = "the maximum access mask for directories allows to";
          descHas = "the maximum access mask for directories allows";
          descIsDenied = "the maximum access for directories denies";
          isDir = true;
        };

        fileMask = mkPermOpts {
          descCan = "the maximum access mask for files allows to";
          descHas = "the maximum access mask for files allows";
          descIsDenied = "the maximum access for files denies";
          isDir = false;
          execute = false;
        };
      };

      postCreate = mkPostCreateUpdateOpt false false;
      postUpdate = mkPostCreateUpdateOpt true false;
      postCreateAsRoot = mkPostCreateUpdateOpt false true;
      postUpdateAsRoot = mkPostCreateUpdateOpt true true;

      users = lib.mkOption {
        type = types.attrsOf (types.submodule {
          options = mkDirPermOpts {
            descCan = "the user can";
            descHas = "the user has";
            descIsDenied = "the user is denied";
          };
        });
        default = {};
        example.foo.write = false;
        description = ''
          Additional users with access to the directory along with permissions.
          The attribute names are the users and the submodule options specify
          its permissions.
        '';
      };

      groups = lib.mkOption {
        type = types.attrsOf (types.submodule {
          options = mkDirPermOpts {
            descCan = "the group can";
            descHas = "the group has";
            descIsDenied = "the group is denied";
            write = false;
          };
        });
        default = {};
        example.bar.write = false;
        description = ''
          Additional groups with access to the directory along with
          permissions. The attribute names are the groups and the submodule
          options specify its permissions.
        '';
      };
    } // lib.optionalAttrs isWebServices {
      # NOTE: If you add any option here, you need to make sure it's removed in
      # modules/core/web/default.nix, because the top-level variant of the
      # "directories" submodule does not contain them.

      instance.before = lib.mkOption {
        type = types.listOf types.str;
        default = [];
        example = [ "my-shiny.service" ];
        description = ''
          Similar to the <option>before</option> option but instead of applying
          to top-level systemd units it applies to systemd units of this web
          service instance.
        '';
      };
    };

    config = lib.optionalAttrs isWebServices {
      before = map mkUnique config.instance.before;
    };
  }));
  default = {};
  example."foo/bar".before = [ "my-shiny.service" ];
  example."foo/bar".owner = "shiny";
  example."foo/bar".group = "shinyones";
  apply = lib.mapAttrs' (path: value: {
    name = let
      maybeBasePath = lib.optionalString isWebServices "${basePath}/";
      sanitized = sanitizePath (maybeBasePath + path);
      errorMsg = "The path '${path}' (canonicalized: '${sanitized}') is"
               + " either invalid or refers to '/', which is not allowed"
               + " for the 'nixcloud.directories' option.";
    in if sanitized == "" then errorMsg else sanitized;
    inherit value;
  });
  description = let
    relativeDoc = "paths relative to <option>${basePathOpt}</option>";
    absoluteDoc = "absolute paths";
  in ''
    Directories to create and set permissions for.

    The attribute names are <emphasis>always</emphasis>
    ${if isWebServices then relativeDoc else absoluteDoc} and
    components such as <literal>.</literal> and <literal>..</literal> are
    stripped out.

    Also the paths don't need to start with a <literal>/</literal>, because
    that's already implied.
  '';
}
