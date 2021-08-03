require 'rugged'

class GitRepository < ApplicationRecord
	has_many :git_commits
	has_many :git_files, through: :git_commits
	has_many :git_notes, through: :git_commits

	validates :path, presence: true, length: { minimum: 10 }
	#self.repo = Rugged::Repository.new("/repo/path/here")
end
