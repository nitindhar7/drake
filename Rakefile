libdir = "#{File.dirname(__FILE__)}/drake"
$LOAD_PATH.unshift(libdir)
Dir[File.join(libdir, "*.rb")].map { |file| require File.basename(file) }

task :default => :help

task :help do
  puts "Run 'rake -T' to view all tasks"; puts
end

desc " -- bootstrap all media and utilities"
task :bootstrap => [
  'assets:init',
  'license',
  'build_properties'
]

desc " -- setup release items"
task :release => ['release:prepare']

desc " -- generates MIT-LICENSE"
task :license do
  `cp #{libdir}/MIT-LICENSE MIT-LICENSE`
end

desc " -- generates build.properties"
task :build_properties do
  `cp #{libdir}/build.properties build.properties`
end