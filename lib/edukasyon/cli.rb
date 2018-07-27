require 'thor'

class CLI < Thor
  desc "current", "Run rubocop for current"
  def current
    exec "git diff-tree -r --no-commit-id --name-only develop@\{u\} head | xargs ls -1 2>/dev/null | grep '\.rb$' | xargs bundle exec rubocop -a --force-exclusion"
  end
end

