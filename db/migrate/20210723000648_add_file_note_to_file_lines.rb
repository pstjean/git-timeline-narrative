class AddFileNoteToFileLines < ActiveRecord::Migration[6.1]
  def change
    add_reference :file_lines, :file_note, null: false, foreign_key: true
  end
end
