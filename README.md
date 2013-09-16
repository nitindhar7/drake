drake (Droid + Rake == Drake)
=============================

Drake makes resource management simple for android (& maybe others?) apps easy by providing asset, release, util scripts.

### Using Drake

Add Drake as a submodule to your android (or other) app:

    git submodule add git@github.com:nitindhar7/drake.git drake

Add the following symlink:

    ln -s drake/Rakefile ./Rakefile

Run `bootstrap` to setup assets, license file, build properties, etc:

    rake bootstrap

### TODO

- Extend Drake to be a generic installtion package
  - git bash completion
