#!/usr/bin/env ruby
command = ENV["SSH_ORIGINAL_COMMAND"]
repo = Repo.find_by_name(command.split(" ")[1])

key = Key.includes(:user).find(ARGV[0])
user = key.user

if(repo.check_user_permission(user))
	system(command)
else
	if(repo.check_group_permission(user.groups))
		system(command)
	else
		abort("Permission denied for repository: #{repo.name}")
	end
end
