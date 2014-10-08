class Hook < ActiveRecord::Base
  belongs_to :repo
  validates :type, :uniqueness => {:scope=>:repo_id}

  def supported_hooks
  	["pre-receive", "post-receive", "update"]
  end

  def save_hook_file

  end

  def delete_hook_file

  end

end
