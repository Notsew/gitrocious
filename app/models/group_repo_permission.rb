class GroupRepoPermission < ActiveRecord::Base
  belongs_to :group
  belongs_to :repo

  validates :branch, presence: true
  validates :branch, uniqueness: true

  def self.check_permissions(group_ids, repo_id, branch)
  	branch = branch.split("/").last
  	permissions = GroupRepoPermission.where(:group_id => group_ids, :repo_id => repo_id, :branch => ["all",branch]).first
  	return true unless !permissions
  	return false
  end
end
