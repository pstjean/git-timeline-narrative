class AddObjectHashUniqueToGitCommits < ActiveRecord::Migration[6.1]
  def change
    add_index :git_commits, :object_hash, unique: true
  end
end
