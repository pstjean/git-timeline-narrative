class GitFile < ApplicationRecord
  belongs_to :git_commit
  has_many :git_notes, through: :file_notes
end
