# frozen_string_literal: true
require 'github_api'

module WunderlistToGithub
  # Collects Tasks from list in Wunderlist.
  class GitHubSink
    def initialize(login, api_token)
      @github = Github.new(login: login, password: api_token)
    end

    # Accepts a hash of a task and creates an issue in the GitHub login's
    # repository. If given a block, the task that was just converted to a
    # GitHub issue is passed back to record any side effects.
    def convert(task_hashes, user, repo_name)
      task_hashes.each do |t|
        issue_hash = convert_task_hash_to_issue_hash(t)
        issue_hash[:user] = user
        issue_hash[:repo] = repo_name
        @github.issues.create(issue_hash)

        yield(t) if block_given?
      end
    end

    def convert_task_hash_to_issue_hash(task_hash)
      {
        title: task_hash[:title],
        body: <<~BODY
        _Imported from Wunderlist_
        #{note_text(task_hash)}
        #{subtask_text(task_hash)}
        #{comment_text(task_hash)}
        BODY
      }
    end

    def note_text(task_hash)
      note = task_hash[:note]
      if note.respond_to?(:length) && note.length.positive?
        "\n# Note\n\n#{note}"
      else
        ''
      end
    end

    def subtask_text(task_hash)
      subtasks = task_hash[:subtasks]
      if subtasks.respond_to?(:length) && subtasks.length.positive?
        "\n# Subtasks\n\n" + subtasks.map do |s|
          " - [ ] #{s}"
        end.join("\n")
      else
        ''
      end
    end

    def comment_text(task_hash)
      comments = task_hash[:comments]
      if comments.respond_to?(:length) && comments.length.positive?
        "\n# Comments\n\n" + comments.join("\n")
      else
        ''
      end
    end
  end
end
