class UserRepoPermission < ActiveRecord::Base
  belongs_to :user
  belongs_to :repo

  validates :branch, presence: true
  validates :branch, uniqueness: true

  def self.check_permissions(user_id, repo_id, branch)
  	branch = branch.split("/").last
  	permissions = UserRepoPermission.where(:user_id => user_id, :repo_id => repo_id, :branch => ["all",branch]).first
  	return true unless !permissions
  	return false
  end
end
