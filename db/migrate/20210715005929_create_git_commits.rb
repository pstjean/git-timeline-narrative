class CreateGitCommits < ActiveRecord::Migration[6.1]
  def change
    create_table :git_commits do |t|
      t.string :hash
      t.references :git_repository, null: false, foreign_key: true

      t.timestamps
    end
    add_index :git_commits, :hash, unique: true
  end
end
