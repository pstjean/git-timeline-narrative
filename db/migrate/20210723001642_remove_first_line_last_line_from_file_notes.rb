class RemoveFirstLineLastLineFromFileNotes < ActiveRecord::Migration[6.1]
  def change
    remove_column :file_notes, :first_line, :integer
    remove_column :file_notes, :last_line, :integer
  end
end
