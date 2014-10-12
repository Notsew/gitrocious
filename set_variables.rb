#!/usr/bin/env ruby
require APP_PATH = File.expand_path('../config/application',  __FILE__)
require File.expand_path('../config/boot',  __FILE__)
# set Rails.env here if desired
Rails.env="production"
Rails.application.require_environment!

command = ENV["SSH_ORIGINAL_COMMAND"]
ENV["GITROCIOUS_REPO_NAME"] = command.split(" ")[1].tr("'","")
ENV["GITROCIOUS_USER_KEY"] = ARGV[0]
ENV["GITROCIOUS_FILE_LOCATION"] = Rails.root.to_s
Dir.chdir(Rails.application.config.repo_location) do |f|
	system(command)
end