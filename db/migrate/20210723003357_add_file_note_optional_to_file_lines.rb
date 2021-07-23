class AddFileNoteOptionalToFileLines < ActiveRecord::Migration[6.1]
  def change
    remove_reference :file_lines, :file_note, null: false, foreign_key: true
    add_reference :file_lines, :file_note, null: true, foreign_key: true
  end
end
