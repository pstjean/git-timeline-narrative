class AddCommitRelationshipToGitNotes < ActiveRecord::Migration[6.1]
  def change
    add_reference :git_notes, :git_commit, null: false, foreign_key: true
  end
end
