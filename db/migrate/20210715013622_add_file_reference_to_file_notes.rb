class AddFileReferenceToFileNotes < ActiveRecord::Migration[6.1]
  def change
    add_reference :file_notes, :git_file, null: false, foreign_key: true
    remove_reference :file_notes, :git_commit, null:false, foreign_key: true
  end
end
