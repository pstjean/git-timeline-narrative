class RemoveHashIndexGitCommits < ActiveRecord::Migration[6.1]
  def change
    remove_index :git_commits, :hash
  end
end
