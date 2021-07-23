class CreateFileLines < ActiveRecord::Migration[6.1]
  def change
    create_table :file_lines do |t|
      t.integer :new_line_number
      t.integer :old_line_number
      t.string :line_origin
      t.text :content
      t.references :git_file, null: false, foreign_key: true

      t.timestamps
    end
  end
end
