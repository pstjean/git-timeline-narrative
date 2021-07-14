class CreateGitNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :git_notes do |t|

      t.timestamps
    end
  end
end
