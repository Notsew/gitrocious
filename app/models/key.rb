class Key < ActiveRecord::Base
  belongs_to :user

  private

  def remove_from_file
  	
  end
end
