class User < ActiveRecord::Base
	has_many :keys, dependent: :destroy
	has_many :user_repo_permissions, dependent: :destroy
	has_many :repos, through: :user_repo_permissions
	has_and_belongs_to_many :groups

	validates :name, presence: true
	validates :name, uniqueness: true
end
