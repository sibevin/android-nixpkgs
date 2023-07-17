{ lib
, stdenv
, devshell
, gradle
, gradle-properties
, jdk8
, update-locks
}:

with lib;

devshell.mkShell {
  name = "android-nixpkgs";

  env = [
    {
      name = "JAVA_HOME";
      eval = "${jdk8.home}";
    }
  ];

  packages = [
    gradle
    jdk8
  ];

  devshell.startup = {
    gradle-properties.text = ''
      rm -f $PRJ_ROOT/gradle.properties
      ln -sf ${gradle-properties} $PRJ_ROOT/gradle.properties
    '';
  };

  commands = [
    {
      name = "update-locks";
      help = "Update dependency lockfiles.";
      category = "development";
      package = update-locks;
    }
  ];
}
