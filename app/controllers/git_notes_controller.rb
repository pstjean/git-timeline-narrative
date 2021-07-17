class GitNotesController < ApplicationController
  def index
    @git_notes = GitNote.all
  end
end
