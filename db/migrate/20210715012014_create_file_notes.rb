class CreateFileNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :file_notes do |t|
      t.integer :first_line
      t.integer :last_line
      t.text :comment
      t.references :git_note, null: false, foreign_key: true
      t.references :git_commit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
