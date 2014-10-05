class Key < ActiveRecord::Base
  belongs_to :user

  validates :value, :user, presence: true

  after_create :add_to_file
  after_destroy :remove_from_file
  
  private

  def add_to_file
  	open("#{ENV['HOME']}/.ssh/authorized_keys", 'a') do |f|
	  f.puts self.value
	end
  end

  def remove_from_file
  	`sed -i.bak "/#{self.value}/d" "#{ENV['HOME']}/.ssh/authorized_keys"`
  end
end
