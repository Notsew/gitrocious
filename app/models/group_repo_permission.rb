class GroupRepoPermission < ActiveRecord::Base
  belongs_to :group
  belongs_to :repo

  validates :branch, presence: true
  validates :branch, uniqueness: true
end
