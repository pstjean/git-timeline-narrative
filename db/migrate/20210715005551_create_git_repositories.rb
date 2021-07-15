class CreateGitRepositories < ActiveRecord::Migration[6.1]
  def change
    create_table :git_repositories do |t|
      t.string :path

      t.timestamps
    end
  end
end
