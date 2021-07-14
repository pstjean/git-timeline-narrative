class CreateGitNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :git_notes do |t|
      t.string :path     # example: "/path/to/file.rb"
      t.integer :line    # starting line of note
      t.integer :column  # starting column of note
      t.text :body       # body of note

      t.timestamps
    end
  end
end
