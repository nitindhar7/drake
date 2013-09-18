drake
=============================

Drake simplifies day-to-day infrastructure tasks we all encounter repetitively when developing projects including bootstrap files (.dotfiles), assets, providing utility/release scripts, etc. Along with that it can be used to manage software installation by recording commands in a configurable registry file.

* * *

### Using Drake

**AD HOC**

Just run `rake -T` for a list of all tasks and their descriptions:

    $ rake -T
	rake android:assets:init             # -- create assets directories for images (all resolutions)
	rake android:assets:promote          # -- optimize and promote assets to app resources
	rake android:bootstrap               # -- bootstrap all media and utilities for Android projects
	rake android:release                 # -- setup release items for Android projects
	rake android:release:generate        # -- generate release key
	rake android:release:prepare         # -- ensures project is releasable
	rake core:build_properties           # -- generates a build.properties template
	rake core:install[command,registry]  # -- executes installation commands and saves them to the configured registry (eg: rake core:install["sudo apt-get install ant, ~/ndhar/.install"])
	rake core:license                    # -- generates a MIT-LICENSE template

**IN EXISTING PROJECTS**

Add `drake` as a _submodule_ to your existing app:

    $ git submodule add git@github.com:nitindhar7/drake.git drake

Add the following symlink:

    $ ln -s drake/Rakefile ./Rakefile

* * *

### Examples

**Android**

Suppose you create a new Android project. You go to your favorite Android IDE (most likely Eclipse or Intellij IDEA). You create a new project and are ready to start work. As you create images to use in your app you realize that you want to store the originals, but you also want to optimize and compress the originals before using them in the app. So you think to create an `assets` directory. With `drake` you can do something like:

    rake android:assets:init

Once your assets folder structure is ready you can store originals in there and promote the images when you're ready:

    rake android:assets:promote

which copies the images from assets, compressing them en-route, to the `res/` directory. Great, now say you're ready to publish your app to the Play Store. Here's how you can run a prep task:

    rake android:release:prepare

This task just runs a few commands to ensure that your app is *ready* for release. Once you're satisfied, you want generate an APK like so:

    rake android:release:generate

In short to bootstrap your project with `assets`, `build.properties`, `MIT-LICENSE` run:

    rake android:bootstrap

and for image promotion and release support run:

    rake android:release

**Installation Management**

The install command is quite dumb and all it does is it runs a command and appends it to a given "registry" file. The purpose is to easily run install commands and record them as you go.

    rake core:install["sudo apt-get install ant, ~/billybob/.install"]

* * *

### Features

[ ] Capture output of `rake core:install[command, registry]` and store it somewhere
[ ] add support for .dotfiles/.bootfiles

* * *

### TODO

[ ] gem-ify