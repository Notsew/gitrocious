class CreateHooks < ActiveRecord::Migration
  def change
    create_table :hooks do |t|
      t.string :type
      t.string :text
      t.references :repo, index: true

      t.timestamps
    end
    add_index :hooks, :type
  end
end
