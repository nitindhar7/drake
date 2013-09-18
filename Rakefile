resdir = "#{File.dirname(__FILE__)}/resource"
libdir = "#{File.dirname(__FILE__)}/lib"
$LOAD_PATH.unshift(libdir)
Dir[File.join(libdir, "*.rb")].map { |file| require File.basename(file) }

task :default => :help

task :help do
  puts "Run 'rake -T' to view all tasks"; puts
end

namespace :core do

  desc " -- generates a MIT-LICENSE template"
  task :license do
    `cp #{resdir}/MIT-LICENSE MIT-LICENSE`
  end

  desc " -- generates a build.properties template"
  task :build_properties do
    `cp #{resdir}/build.properties build.properties`
  end

  desc " -- executes installation commands and saves them to the configured registry (eg: rake core:install[\"sudo apt-get install ant, ~/ndhar/.install\"])"
  task :install, :command, :registry do |t, args|
    puts `echo 'Will run \'#{args[:command]}\'...' && #{args[:command]} && echo ' ... done'`
    `echo '#{args[:command]}' >> #{args[:registry]}`
  end

end

namespace :android do

  desc " -- bootstrap all media and utilities for Android projects"
  task :bootstrap => [
    'android:assets:init',
    'core:license',
    'core:build_properties'
  ]

  desc " -- setup release items for Android projects"
  task :release => [
    'android:release:prepare',
    'android:release:generate'
  ]

end