libdir = "#{File.dirname(__FILE__)}/rakelib"
$LOAD_PATH.unshift(libdir)
Dir[File.join(libdir, "*.rb")].map { |file| require File.basename(file) }

task :default => :help

task :help do
  puts "Run 'rake -T' to view all tasks"; puts
end

desc " -- bootstrap all media and utilities"
task :bootstrap => ['assets:init']

desc " -- setup release items"
task :release => ['release:prepare']