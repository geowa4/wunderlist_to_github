# frozen_string_literal: true
require 'github_api'

module WunderlistToGithub
  # Collects Tasks from list in Wunderlist.
  class GitHubSink
    def initialize(login, api_token)
      @github = Github.new(login: login, password: api_token)
    end

    def convert(task, user, repo_name)
      task_hash = convert_task_to_hash(task)
      issue_hash = convert_task_hash_to_issue_hash(task_hash)
      issue_hash[:user] = user
      issue_hash[:repo] = repo_name
      @github.issues.create(issue_hash)
    end

    def convert_task_to_hash(task)
      {
        title: task.title,
        completed: task.completed,
        note: task.note.content,
        comments: task.task_comments.map(&:text),
        subtasks: task.subtasks.map(&:title)
      }
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
      if task_hash[:note].length.positive?
        "# Note\n\n#{task_hash[:note]}"
      else
        ''
      end
    end

    def subtask_text(task_hash)
      if task_hash[:subtasks].length.positive?
        "# Subtasks\n\n" + task_hash[:subtasks].map do |s|
          " - [ ] #{s}"
        end.join("\n")
      else
        ''
      end
    end

    def comment_text(task_hash)
      if task_hash[:comments].length.positive?
        "# Comments\n\n" + task_hash[:comments].join("\n")
      else
        ''
      end
    end
  end
end
