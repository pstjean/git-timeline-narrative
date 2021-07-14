class GitNotesController < ApplicationController
  def index
    @git_notes = Git_Note.all
  end
end
