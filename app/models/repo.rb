class Repo < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_and_belongs_to_many :groups

	after_create :create_repo
	after_destroy :destroy_repo

	private

	def create_repo
		Dir.chdir("#{ENV["HOME"]}/repos") do |f|
			`git init --bare #{self.name}`
		end
	end

	def destroy_repo
		FileUtils.rm_rf("#{ENV["HOME"]}/repos/#{self.name}")
	end
end
