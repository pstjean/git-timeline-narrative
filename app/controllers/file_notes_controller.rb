class FileNotesController < ApplicationController
  def index
  end

  def create
    @file_note = FileNote.create(file_note_params)
    unless @file_note.valid?
      puts @file_note.errors.full_messages
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def file_note_params
      whitelisted_params = params.require(:file_note).permit(:comment, :git_file_id, file_line_ids:[])
      whitelisted_params[:git_note_id] = params.require(:git_note_id)
      puts "WHITELISTED"
      puts whitelisted_params
      whitelisted_params
    end
end
