class AddObjectHashToGitCommit < ActiveRecord::Migration[6.1]
  def change
    add_column :git_commits, :object_hash, :string, null: false, default: ''
  end
end
