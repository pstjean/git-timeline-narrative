class AddFilenameUniqueToGitFiles < ActiveRecord::Migration[6.1]
  def change
    add_index :git_files, %i[filename git_commit_id], unique: true
  end
end
