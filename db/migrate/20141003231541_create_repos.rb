class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :name

      t.timestamps
    end
    add_index :repos, :name
  end
end
