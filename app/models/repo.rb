class Repo < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_and_belongs_to_many :groups

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
	end

	def destroy_repo
		FileUtils.rm_rf("#{self.path_to_repo}")
	end
end
