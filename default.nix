self: super: with super; rec {
  python3 = super.python3.override {
    packageOverrides = pySelf: pySuper: {
      trimesh = pySuper.callPackage ./cura/python-modules/trimesh {};
      uranium = pySuper.callPackage ./cura/python-modules/uranium {};
    };
  };

  curaengine_latest = callPackage ./cura/engine { inherit (python3.pkgs) libarcus; };
  cura_latest = qt5.callPackage ./cura { curaengine = curaengine_latest; };
  curaPlugins_latest = callPackage ./cura/plugins.nix { };

  horizon-eda = callPackage ./horizon {};

  librepcb = libsForQt5.callPackage ./librepcb {};

  fungw = callPackage ./pcb-rnd/fungw {
    lua = lua5_1;
  };
  genht = callPackage ./pcb-rnd/genht {};
  pcb-rnd = callPackage ./pcb-rnd {
    inherit genht fungw;
    gtk = gtk2;
    gtkglext = gnome2.gtkglext;
  };
}
