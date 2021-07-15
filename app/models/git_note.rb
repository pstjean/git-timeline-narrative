require 'rugged'

class GitNote < ApplicationRecord
  belongs_to :git_commit
  # attr_reader :head, :repo

  # def initialize args
  #   puts args
  #   @repo = Rugged::Repository.new(args[:path])
  #   @head = @repo.head
  # end
end
