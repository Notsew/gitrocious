class Key < ActiveRecord::Base
  belongs_to :user

  validates :value, :user, presence: true
  validates :value, uniqueness: true

  after_create :add_to_file
  after_destroy :remove_from_file
  
  private

  def command
    "command=\"#{Rails.application.config.gitrocious_command} #{self.id}\" #{self.value}"
  end

  def add_to_file
  	open("#{ENV['HOME']}/.ssh/authorized_keys", 'a') do |f|
  	  f.puts command
  	end
  end

  def remove_from_file
    output_file = "#{ENV['HOME']}/.ssh/authorized_keys.tmp"
    input_file = "#{ENV['HOME']}/.ssh/authorized_keys"
    File.open(output_file, "w") do |out_file|
      File.foreach(input_file) do |line|
        out_file.puts line unless line.chomp == command
      end
    end

    FileUtils.mv(output_file, input_file)
  end
end
