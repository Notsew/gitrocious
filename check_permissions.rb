#!/usr/bin/env ruby
APP_PATH = File.expand_path('../config/application',  __FILE__)
require File.expand_path('../config/boot',  __FILE__)
require APP_PATH
# set Rails.env here if desired
Rails.env="production"
Rails.application.require_environment!

command = ENV["SSH_ORIGINAL_COMMAND"]
repo = Repo.find_by_name(command.split(" ")[1])

key = Key.includes(:user).find(ARGV[0])
user = key.user

if(repo.check_user_permission(user))
	Dir.chdir(Rails.application.config.repo_location) do |f|
		system(command)
	end
else
	if(repo.check_group_permission(user.groups))
		Dir.chdir(Rails.application.config.repo_location) do |f|
			system(command)
		end
	else
		abort("Permission denied for repository: #{repo.name}")
	end
end
