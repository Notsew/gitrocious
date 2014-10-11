class Group < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :group_repo_permissions, dependent: :destroy
	has_many :repos, through: :group_repo_permissions
	
	validates :name, presence: true
	validates :name, uniqueness: true
end
