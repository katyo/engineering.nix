self: super: with super; rec {
  python3 = super.python3.override {
    packageOverrides = pySelf: pySuper: {
      trimesh = pySuper.callPackage ./cura/python-modules/trimesh {};
      uranium = pySuper.callPackage ./cura/python-modules/uranium {};
      pynest2d = pySuper.callPackage ./cura/python-modules/pynest2d {};
    };
  };

  libnest2d = callPackage ./cura/libraries/libnest2d {};

  curaengine_latest = callPackage ./cura/engine {
    inherit (python3.pkgs) libarcus;
  };
  cura_latest = qt5.callPackage ./cura {
    curaengine = curaengine_latest;
    plugins = with curaPlugins_latest; [ octoprint ];
  };
  curaPlugins_latest = callPackage ./cura/plugins.nix { };

  horizon-eda = callPackage ./horizon {};

  librepcb = libsForQt5.callPackage ./librepcb {};

  trilinos = callPackage ./trilinos { lapack = liblapack; };
  xyce = callPackage ./xyce { inherit trilinos; lapack = liblapack; };

  qucs = callPackage ./qucs {};

  fungw = callPackage ./pcb-rnd/fungw {
    lua = lua5_1;
  };
  genht = callPackage ./pcb-rnd/genht {};
  pcb-rnd = callPackage ./pcb-rnd {
    inherit genht fungw;
    gtk = gtk2;
    gtkglext = gnome2.gtkglext;
  };

  gitui = callPackage ./gitui {};
}
