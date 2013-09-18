require "util"

namespace :android do

  namespace :assets do

    ASSETS_DIR = 'assets'
    RESOURCES_DIR = "res"
    IMAGE_ASSETS_DIR = "#{ASSETS_DIR}/images"
    DRAWABLE_DIR = "#{RESOURCES_DIR}/drawable"
  
    RESOLUTIONS = ['ldpi', 'mdpi', 'hdpi', 'xhdpi']

    desc " -- create assets directories for images (all resolutions)"
    task :init do
      `mkdir -pv #{ASSETS_DIR}` if !File.directory? ASSETS_DIR
      `mkdir -pv #{IMAGE_ASSETS_DIR}` if !File.directory? IMAGE_ASSETS_DIR
       RESOLUTIONS.each do |resolution|
        dir = "#{IMAGE_ASSETS_DIR}/#{resolution}"
        `mkdir -pv #{dir}` if !File.directory? dir
      end
      `mkdir -pv #{DRAWABLE_DIR}` if !File.directory? DRAWABLE_DIR
    end

    desc " -- optimize and promote assets to app resources"
    task :promote do
      RESOLUTIONS.each do |resolution|
        asset_dir = "#{IMAGE_ASSETS_DIR}/#{resolution}"
        res_dir = "#{RESOURCES_DIR}/drawable-#{resolution}"
        puts "Optimizing [#{asset_dir}]"
        images = `ls #{asset_dir}`.split("\n")
          images.each do |image|
          puts "WARN: Invalid filename [#{image}] => attempting to fix" if image.match("-")
          `cp #{asset_dir}/#{image} /tmp`
          `optipng -o5 --quiet /tmp/#{image}`
          `convert -depth 6 -quality 90 /tmp/#{image} #{res_dir}/#{image.match("-") ? image.gsub(/-/, '_') : image}`
          `rm /tmp/#{image}`
          puts "  * #{image} => #{res_dir}/#{image}"
        end
      end
    end

  end

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

end