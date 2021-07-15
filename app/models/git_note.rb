require 'rugged'

class GitNote < ApplicationRecord
  belongs_to :git_commit
  has_many :git_files, through: :file_notes
  # attr_reader :head, :repo

  # def initialize args
  #   puts args
  #   @repo = Rugged::Repository.new(args[:path])
  #   @head = @repo.head
  # end
end
