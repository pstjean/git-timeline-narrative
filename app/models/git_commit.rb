class GitCommit < ApplicationRecord
  belongs_to :git_repository
  has_one :git_note
  has_many :git_files
end
