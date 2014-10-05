namespace :gitrocious do
  desc "set admin and path to repos"
  task setup: :environment do
  	puts "Creating db and running migrations..."
  	`rake db:create RAILS_ENV=production`
  	`rake db:migrate RAILS_ENV=production`
  	puts "Enter admin user name(defaults to admin):"
  	admin_name = STDIN.gets.chomp
  	puts "Enter admin password(defaults to password):"
  	admin_password = STDIN.gets.chomp
  	puts "Enter location of repositories(defaults to /home/<user>/repos):"
  	repo_location = STDIN.gets.chomp
    puts "Are you using RVM(default is n)? (y/n)"
    rvm = STDIN.gets.chomp

    home = ENV["HOME"]
    if(rvm.blank?)
      rvm = "n"
    end
  	if(repo_location.blank?)
  		repo_location = "#{home}/repos"
  	end
  	if(admin_name.blank?)
  		admin_name = "admin"
  	end
  	if(admin_password.blank?)
  		admin_password = "password"
  	end
    if(rvm == "y")
      command = "source #{home}/.rvm/scripts/rvm && cd #{Rails.root.to_s}/gitrocious && rails runner -e production check_permission.rb"
    else
      command = "cd #{home}/gitrocious && rails runner -e production check_permission.rb"
    end

    if(!Dir.exists?(repo_location))
      FileUtils.mkdir(repo_location)
    end

    secret = `rake secret`.tr("\n","")
  	
    config = %Q{
  	Rails.application.config.admin_username = "#{admin_name}"
  	Rails.application.config.admin_password = "#{admin_password}"
  	Rails.application.config.repo_location = "#{repo_location}"
    Rails.application.config.gitrocious_command = "#{command}"
    ENV["SECRET_KEY_BASE"] = "#{secret}"
  	}
  	
    path = "#{Rails.root}/config/initializers/gitrocious.rb"
  	
    if(!File.exists?(path))
  		File.open(path, "w+") do |f|
		  f.write(config)
		end
	end

  	#puts `echo $HOME`

  end

end
