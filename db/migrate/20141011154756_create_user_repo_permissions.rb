class CreateUserRepoPermissions < ActiveRecord::Migration
  def change
    create_table :user_repo_permissions do |t|
      t.string :branch
      t.references :user, index: true
      t.references :repo, index: true

      t.timestamps
    end
  end
end
