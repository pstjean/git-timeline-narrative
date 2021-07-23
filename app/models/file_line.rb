class FileLine < ApplicationRecord
  belongs_to :git_file

  validates :line_origin,
            inclusion: {
              in: %w[
                context
                addition
                deletion
                eof_no_newline
                eof_newline_added
                eof_newline_removed
                file_header
                hunk_header
                binary
              ],
              message: '%{value} is not a valid origin'
            }
end
