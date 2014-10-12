class Repo < ActiveRecord::Base
	has_many :user_repo_permissions, dependent: :destroy
	has_many :group_repo_permissions, dependent: :destroy
	has_many :users, through: :user_repo_permissions
	has_many :groups, through: :group_repo_permissions

	validates :name, presence: true
	validates :name, uniqueness: true

	after_create :create_repo
	after_destroy :destroy_repo

	def path_to_repo
		"#{Rails.application.config.repo_location}/#{self.name}.git"
	end

	def branches
		Dir.chdir("#{self.path_to_repo}") do |f|
			branches = `git branch`
			branches = branches.split(" ")
			branches.delete("*")
			if branches.nil?
				return []
			else
				return branches
			end
		end
	end

	def hooks
		hooks = Dir.entries("#{self.path_to_repo}/hooks")
		hooks.delete(".")
		hooks.delete("..")
		hooks.delete("update")
		hooks
	end

	def check_user_permission(user)
		if(self.users.include?(user))
			return true
		else
			return false
		end
	end

	def check_group_permission(groups)
		groups.each do |group|
			if(self.groups.include?(group))
				return true
			end
		end
		return false
	end

	private

	def create_repo
		Dir.chdir("#{Rails.application.config.repo_location}") do |f|
			`git init --bare --template=#{Rails.root}/gitrocious-template #{self.name}.git`
		end
		update_path = "#{Rails.root}/update"
		link_path = "#{self.path_to_repo}/hooks/update"
		File.symlink(update_path,link_path)
	end

	def destroy_repo
		FileUtils.rm_rf("#{self.path_to_repo}")
	end
end
