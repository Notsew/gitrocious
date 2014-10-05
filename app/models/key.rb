class Key < ActiveRecord::Base
  belongs_to :user

  validates :value, :user, presence: true

  private

  def remove_from_file

  end
end
