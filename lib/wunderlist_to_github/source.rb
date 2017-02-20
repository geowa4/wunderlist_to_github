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

    def tasks(list_name)
      @wl.tasks([list_name])
    end
  end
end
