class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.string :value
      t.references :user, index: true

      t.timestamps
    end
    add_index :keys, :value
  end
end
