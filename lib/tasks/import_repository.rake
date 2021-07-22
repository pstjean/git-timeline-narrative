require 'tty-prompt'

namespace :repository do
  desc 'Import a repository into the system'
  task :import, [:path] => [:environment] do |t, args|
    repo = Rugged::Repository.new(args['path'])
    repo_entity = GitRepository.create(path: args['path'])
    walker = Rugged::Walker.new(repo)

    # walker.sorting(Rugged::SORT_TOPO | Rugged::SORT_REVERSE) # optional
    walker.push(repo.head.target_id)

    # walker.hide(hex_sha_uninteresting)
    # walker.each { |c| puts c.inspect }
    commit_choices = {}
    walker.each do |c|
      commit_choices["#{c.oid[0..7]} - #{c.message.chomp}".to_sym] = c.oid
    end

    prompt = TTY::Prompt.new
    selected_shas = prompt.multi_select('Select commits', commit_choices)
    puts selected_shas

    selected_shas.each do |sha|
      commit = repo.lookup(sha)
      commit_entity =
        GitCommit.create(object_hash: commit.oid, git_repository: repo_entity)

      commit
        .diff
        .patches
        .each do |patch|
          patch.hunks.each do |hunk|
            old_path, new_path =
              hunk.delta.delta.old_file[:path], hunk.delta.delta.new_file[:path]

            file_entity =
              GitFile.create(filename: new_path, git_commit: commit_entity)

            old_file_entity =
              GitFile.create(
                filename: old_path,
                git_commit: commit_entity
              ) if old_path != new_path

            puts hunk.header
            hunk.lines.each do |line|
              # From https://github.com/libgit2/rugged/blob/master/lib/rugged/diff/line.rb
              possible_line_origins = %i[
                context
                addition
                deletion
                eof_no_newline
                eof_newline_added
                eof_newline_removed
                file_header
                hunk_header
                binary
              ]
            end
          end
        end
      # commit.diff.patches[0].hunks[0].delta.delta
      # Hunk Patch
      # commit.diff.patches[0].hunks[0].delta
      # Hunk Diff Delta
      # commit.diff.patches[0].hunks[0].delta.delta

      # puts commit.oid
    end

    # if answer.downcase == 'y'
    #   commit_entities.push(
    #     GitCommit.create(object_hash: c.oid, git_repository: repo_entity)
    #   )
    # end

    walker.reset
  end
end
