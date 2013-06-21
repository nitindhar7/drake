require "util"

namespace :release do

  include Util

  desc " -- ensures project is releasable"
  task :prepare do
    puts `echo '\nLogging:             ' && egrep -rn 'Log\.' src/`
    puts `echo '\nDebuggable:          ' && egrep -rn 'android:debuggable' AndroidManifest.xml`
    puts `echo '\nVersion Code:        ' && egrep -rn 'android:versionCode' AndroidManifest.xml`
    puts `echo '\nVersion Name:        ' && egrep -rn 'android:versionName' AndroidManifest.xml`
    puts `echo '\nIcon:                ' && egrep -rn 'android:icon' AndroidManifest.xml`
    puts `echo '\nApp Name:            ' && egrep -rn 'android:label' AndroidManifest.xml`
    puts `echo '\nMinimum SDK Version: ' && egrep -rn 'android:minSdkVersion' AndroidManifest.xml`
    puts `echo '\nTarget SDK Version:  ' && egrep -rn 'android:targetSdkVersion' AndroidManifest.xml`
  end

  desc " -- generate release key"
  task :generate do
    cmd = "keytool -genkey -v -keystore #{config[Util::CONFIG_KEY_PROJECT_NAME]}-release-key.keystore " +
    "-alias #{config[Util::CONFIG_KEY_PROJECT_NAME]}-key -keyalg RSA -keysize 2048 -validity 18250"
    `#{cmd}`
  end

end