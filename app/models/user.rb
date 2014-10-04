class User < ActiveRecord::Base
	has_many :keys, dependent: :destroy
	has_and_belongs_to_many :repos
	has_and_belongs_to_many :groups
end
