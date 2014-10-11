#!/usr/bin/env ruby
command = ENV["SSH_ORIGINAL_COMMAND"]
ENV["GITROCIOUS_REPO_NAME"] = command.split(" ")[1].tr("'","")
ENV["GITROCIOUS_USER_KEY"] = ARGV[0]

system(command)