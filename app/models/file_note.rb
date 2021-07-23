class FileNote < ApplicationRecord
  belongs_to :git_note
  belongs_to :git_file
  has_many :file_lines
end
