# frozen_string_literal: true
require 'spec_helper'
require 'wunderlist'
require 'wunderlist_to_github'

RSpec.describe WunderlistToGithub do
  it 'has a version number' do
    expect(WunderlistToGithub::VERSION).not_to be nil
  end
end
