require 'rugged'

class GitNote < ApplicationRecord
  belongs_to :git_commit
  has_many :file_notes
  has_many :git_files, through: :file_notes
  attr_accessor :head, :repo
  # after_create :initialize_rugged

  def parse(note_text)
    # parses strings with the following format:
    # /path/to/file.rb 3,3245
    # This text refers to lines 3 and 3245
    m = note_text.match /^(\/.+\.rb)\s+(\d+),(\d+)\s+([\w\s]+)/ # regex captures string into groups

    filepath = m[1] # => "/path/to/file.rb"
    first = m[2] # => "3"
    last = m[3] # => "3245"
    body = m[4] # => "This text refers to lines 3 and 3245"

    FileNote.create(path: filepath, 
                    first_line: first, 
                    last_line: last, 
                    content: body, 
                    git_note: self)
  end
  
  private

  def initialize_rugged
    # self.repo = Rugged::Repository.new(self.git_commit.git_repository.path)
    # self.head = @repo.head
  end
end
