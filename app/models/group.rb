class Group < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_and_belongs_to_many :repos
	
	validates :name, presence: true
	validates :name, uniqueness: true
end
