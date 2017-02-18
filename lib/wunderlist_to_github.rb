# frozen_string_literal: true
require 'wunderlist_to_github/version'
require 'wunderlist'

# Converts tasks from Wunderlist to GitHub.
module WunderlistToGithub
  # Collects Tasks from list in Wunderlist.
  class WunderlistTaskCollector
    def initialize(client_id, access_token)
      @client_id = client_id
      @access_token = access_token
    end

    def tasks(list_name)
      wl = wunderlist_client
      task_list = wl.list(list_name)
      task_list.tasks
    end

    protected

    def wunderlist_client
      unless defined? @wl
        @wl = Wunderlist::API.new(
          access_token: @access_token,
          client_id: @client_id
        )
      end
      @wl
    end
  end
end
