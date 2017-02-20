# frozen_string_literal: true
require 'wunderlist'

module WunderlistToGithub
  # Collects Tasks from list in Wunderlist.
  class WunderlistSource
    def initialize(client_id, access_token)
      @wl = Wunderlist::API.new(
        access_token: access_token,
        client_id: client_id
      )
    end

    # Returns an array of task hashes containing the most important fields.
    def tasks(list_name)
      @wl.tasks([list_name]).map(&method(:convert_task_to_hash))
    end

    def convert_task_to_hash(task)
      {
        title: task.title,
        completed: task.completed,
        note: task.note.content,
        comments: task.task_comments.map(&:text),
        subtasks: task.subtasks.reverse.map(&:title) # backwards, really?
      }
    end
  end
end
