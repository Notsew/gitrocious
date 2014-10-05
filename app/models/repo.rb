class Repo < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_and_belongs_to_many :groups

	after_create :create_repo
	after_destroy :destroy_repo

	def path_to_repo
		"#{Rails.application.config.repo_location}/#{self.name}"
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
	private

	def create_repo
		Dir.chdir("#{Rails.application.config.repo_location}") do |f|
			`git init --bare #{self.name}`
		end
	end

	def destroy_repo
		FileUtils.rm_rf("#{Rails.application.config.repo_location}/#{self.name}")
	end
end
