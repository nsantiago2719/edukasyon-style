require 'thor'

class CLI < Thor
  desc "current", "Run rubocop for develop"
  def current
    exec "git diff-tree -r --no-commit-id --name-only develop@\{u\} head | xargs ls -1 2>/dev/null | grep '\.rb$' | xargs bundle exec rubocop --force-exclusion"
  end

  desc "default", "Run rubocop for the whole repo"
  def default(*args)
    exec "rubocop #{args.join(' ')}"
  end
  default_task :default
end

