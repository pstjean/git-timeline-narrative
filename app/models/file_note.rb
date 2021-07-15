class FileNote < ApplicationRecord
  belongs_to :git_note
  belongs_to :git_commit
end
