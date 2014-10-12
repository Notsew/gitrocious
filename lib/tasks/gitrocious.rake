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
    puts "Will you be using a web server to serve static assets(Apache,Nginx,etc.) y/n (default is y)?"
    static_assets = STDIN.gets.chomp

    home = ENV["HOME"]
    if(rvm.blank?)
      rvm = "n"
    end
    if(static_assets.blank?)
      static_assets = "y"
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
      command = "source #{home}/.rvm/scripts/rvm && #{Rails.root.to_s}/set_variables.rb"
    else
      command = "#{Rails.root.to_s}/set_variables.rb"
    end
    if(static_assets == "n")
      asset = "Rails.application.config.serve_static_assets = true"
    else
      asset = ""
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
    #{asset}
    ENV["SECRET_KEY_BASE"] = "#{secret}"
  	}
  	
    path = "#{Rails.root}/config/initializers/gitrocious.rb"
		
    File.open(path, "w+") do |f|
	    f.write(config)
		end

    unless File.directory?("#{home}/.ssh")
      FileUtils.mkdir_p("#{home}/.ssh")
      FileUtils.chmod(0700,"#{home}/.ssh")
    end

    puts "Compiling assets for production...."
    `RAILS_ENV=production rake assets:precompile`
    puts "Starting the gitrocious admin site...."
    `puma -d`
  end

end
