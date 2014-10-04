class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.string :value

      t.timestamps
    end
    add_index :keys, :value
  end
end
