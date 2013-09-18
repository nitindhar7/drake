module Util

  CONFIG_KEY_PROJECT_NAME = "project.name"

  def config
    config = {}
    File.open("build.properties").read.each_line do |line|
      property = line.split("=")
      config[property.first] = property.last.chomp
    end
    config
  end

end