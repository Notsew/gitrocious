class CreateGroupRepoPermissions < ActiveRecord::Migration
  def change
    create_table :group_repo_permissions do |t|
      t.string :branch
      t.references :group, index: true
      t.references :repo, index: true

      t.timestamps
    end
  end
end
