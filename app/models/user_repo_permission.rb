class UserRepoPermission < ActiveRecord::Base
  belongs_to :user
  belongs_to :repo

  validates :branch, presence: true
  validates :branch, uniqueness: true
end
