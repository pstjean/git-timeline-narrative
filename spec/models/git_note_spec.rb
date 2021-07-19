require 'rails_helper'
require 'rugged'


RSpec.describe GitNote, type: :model do
  before :all do
    @a_repo = GitRepository.create(path: Rails.root)
    @a_commit = GitCommit.create(object_hash: '12345', git_repository: @a_repo)
    @note_model = GitNote.create(git_commit: @a_commit)
  end
  it "can find a repository" do
    expect(@note_model.head.name).to eq "refs/heads/master"
  end


  # Largely cribbed from https://github.com/libgit2/rugged/blob/master/test/note_test.rb
  it "can create a note in a custom namespace in the repository" do
    person = {:name => 'Peter', :email => 'peter@stjean.co', :time => Time.now }
    message ="This is the note message\n\nThis note is created from Rugged"

    obj = @note_model.head.target
    note_oid = obj.create_note(
      :message => message,
      :committer => person,
      :author => person,
      :ref => 'refs/notes/test',
      :force => true # overwrite if needed
    )

    blob = @note_model.repo.lookup(note_oid)
    expect(blob.oid).to eq note_oid
    expect(blob.content).to eq message
    expect(blob.type).to eq :blob

    note = obj.notes('refs/notes/test')
    expect(note[:oid]).to eq note_oid
    expect(note[:message]).to eq message
  end
end
