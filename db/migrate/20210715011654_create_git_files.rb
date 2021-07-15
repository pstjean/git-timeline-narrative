class CreateGitFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :git_files do |t|
      t.string :filename
      t.references :git_commit, null: false, foreign_key: true

      t.timestamps
    end
  end
end
