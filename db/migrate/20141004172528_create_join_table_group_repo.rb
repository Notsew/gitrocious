class CreateJoinTableGroupRepo < ActiveRecord::Migration
  def change
    create_join_table :groups, :repos do |t|
       t.index [:group_id, :repo_id]
       t.index [:repo_id, :group_id]
    end
  end
end
