***********************
Writing service modules
***********************

The basics for `writing NixOS modules`_ still apply here, but in order to
support multiple instances, a few things are handled differently.

Every service module is treated like a submodule and thus only has the options
available within the submodule context. However, there is a special module
attribute called ``toplevel``, which allows to access ``options`` and
``config`` from normal modules, like for example to access
``system.stateVersion`` the attribute to use is
``toplevel.config.system.stateVersion``.

For passing option definitions back to the top-level, the same attribute exists
within the ``config`` attribute of such a submodule.

However there are cases in which using them should be avoided, because it would
make those services unable to coexist with each other.

Top-level options different in service modules
----------------------------------------------

It's recommended to avoid these top-level options in service modules, because
they interfere with the goal of having multiple instances.

``systemd``
-----------

The same option is available within the service modules, so simply don't use
the ``toplevel.`` option for defining units.

It differs from the top-level option such that it automatically gives the
service name a unique prefix and orders the unit before
``instance-init.target`` (which itself is prefixed with the unique name of the
service).

Unit options such as ``before``, ``after``, ``wantedBy`` and other ordering
options can be prefixed with an ``instance`` attribute to ensure they get
prefixed versions.

For example:

.. code-block:: nix

  {
    systemd.services.foo = {
      wantedBy = [ "multi-user.target" ];
    };

    systemd.services.bar = {
      description = "Bar";
      instance.after = [ "foo.service" ];
    };
  }

This will create two services ``foo`` and ``bar``, which both get their unique
prefix, however there is ``wantedBy``, which is passed to the top-level without
changes but ``instance.after`` passes ``foo.service`` with its instance prefix
to the top-level.

Another deviation from the top-level option is that the ``serviceConfig.User``
and ``serviceConfig.Group`` options are automatically prefixed as well.

``users.users``
---------------

This option is exposed to service modules as just ``users`` and it
automatically prefixes the user name and the ``group`` attribute.

``users.groups``
----------------

Same as with `users.users`_, but only the group name is prefixed.

Other notable options
---------------------

There are also some additional options available which are not part of the
upstream NixOS modules. You can build a reference of these options by running
``nix-build release.nix -A manual`` from the root of this repository.

Note that if you have systemd units defined that are dependant on a database
being up, be sure to order them after ``database.target`` with
``instance.after``.

``database``
------------

Allows to specify databases to use for this service. The attribute name is the
database name and the value is another submodule which specifies
database-specific options.

Some options useful for module developers:

``socketPath``
^^^^^^^^^^^^^^

This option is read-only and the module should always use the socket to
communicate with the database. The reason for this is to avoid the need of
passwords or certificates. Use of this option definition is only for module
developers to find out the right socket path.

``phpHostname``
^^^^^^^^^^^^^^^

Similar to `socketPath`_ but a useful helper for PHP-based web services,
because database connections to sockets are specified differently in PHP
dependending on the database type.

``type``
^^^^^^^^

The database type, which by default is the same as ``defaultDatabaseType``, so
for a service module it should be only set if the application only supports one
specific database type.

``user``
^^^^^^^^

Specifies the user which will have access to the database determined by the
user who connects to the UNIX socket (under the hood it's done by looking up
SO_PEERCRED [1]_).

``postCreate``
^^^^^^^^^^^^^^

Shell script to run directly after the database was created, which allows a
special ``sqlsh`` command, which reads SQL commands from standard input and
executes it on the right database.

``directories``
---------------

This option is also available as a top-level option and it's there to create
directories prior to service startup (which is a fairly common task to do).
The option also exist within the service modules, but instead of specifying
absolute paths, all paths are relative to the ``stateDir`` of the service
module.

``tests.wanted``
----------------

Available at the top-level as well with the same functionality, which is a list
of test expressions for NixOS VM tests that need to pass once this service is
enabled.

Path options
------------

There are two options, ``stateDir`` and ``runtimeDir``, which are both
read-only and meant for module developers to reference the right path for the
instance with its unique directory.

The difference between those two is that ``runtimeDir`` is for files that
do not persist and are only temporary (like sockets), while ``stateDir``
contains all the data that should persist after restarts or reboots.

Other helpers
-------------

The unique prefix for the service module is exposed via the ``uniqueName``
option and there is another helper function that is passed to all modules as an
argument called ``mkUnique``, which prepends the unique name in front of the
string passed to it while removing duplicates (like eg.
``uniquename-uniquename-foo``).

There are also variations of ``mkUnique``, one being ``mkUniqueUser`` and
``mkUniqueGroup`` which are for generating unique names for users and groups
respectively. The reason why this differs from ``mkUnique`` is that user and
group names are limited in length, so we need to hash them if they exceed 32
characters.

.. [1] Look into the `socket(7)`_ manpage in section ``Socket options`` for
       more information.
.. _writing NixOS modules: https://nixos.org/nixos/manual/index.html#sec-writing-modules
.. _socket(7): http://man7.org/linux/man-pages/man7/socket.7.html
