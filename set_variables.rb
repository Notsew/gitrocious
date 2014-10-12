#!/usr/bin/env ruby
command = ENV["SSH_ORIGINAL_COMMAND"]
ENV["GITROCIOUS_REPO_NAME"] = command.split(" ")[1].tr("'","")
ENV["GITROCIOUS_USER_KEY"] = ARGV[0]
ENV["GITROCIOUS_FILE_LOCATION"] = `pwd`
Dir.chdir(Rails.application.config.repo_location) do |f|
	system(command)
end