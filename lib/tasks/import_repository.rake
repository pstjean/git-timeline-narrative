require 'tty-prompt'

namespace :repository do
  desc 'Import a repository into the system'
  task :import, [:path] => [:environment] do |t, args|
    repo = Rugged::Repository.new(args['path'])
    repo_entity = GitRepository.create(path: args['path'])
    walker = Rugged::Walker.new(repo)

    walker.push(repo.head.target_id)

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
              GitFile.find_or_create_by(
                filename: new_path,
                git_commit: commit_entity
              )

            old_file_entity =
              GitFile.find_or_create_by(
                filename: old_path,
                git_commit: commit_entity
              ) if old_path != new_path

            puts hunk.header
            hunk.lines.each do |line|
              FileLine.create(
                line_origin: line.line_origin.to_s,
                content: line.content,
                git_file: file_entity,
                old_line_number: line.old_lineno,
                new_line_number: line.new_lineno
              )
            end
          end
        end
    end

    walker.reset
  end
end
