class RemoveHashFromGitCommit < ActiveRecord::Migration[6.1]
  def change
    change_table :git_commits do |t|
      t.remove :hash
    end
  end
end
