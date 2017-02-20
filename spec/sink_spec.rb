# frozen_string_literal: true
require 'spec_helper'
require 'wunderlist'
require 'wunderlist_to_github/sink'

RSpec.describe WunderlistToGithub::GitHubSink do
  it 'converts task hashes to issue hashes' do
    task_hash = {
      title: 'A title',
      completed: true,
      note: 'Note content',
      comments: ['Comment 1', 'Comment 2'],
      subtasks: ['Sub 1', 'Sub 2']
    }
    gh = WunderlistToGithub::GitHubSink.new '', ''
    issue_hash = gh.convert_task_hash_to_issue_hash(task_hash)
    expect(issue_hash[:title]).to eq('A title')
    expect(issue_hash[:body]).to eq(
      <<~BODY
        _Imported from Wunderlist_

        # Note

        Note content

        # Subtasks

         - [ ] Sub 1
         - [ ] Sub 2

        # Comments

        Comment 1
        Comment 2
      BODY
    )
  end

  it 'leaves out blank notes' do
    task_hash = {
      note: ''
    }
    gh = WunderlistToGithub::GitHubSink.new '', ''
    expect(gh.note_text(task_hash)).to eq('')
  end

  it 'leaves out empty subtask lists' do
    task_hash = {
      subtasks: []
    }
    gh = WunderlistToGithub::GitHubSink.new '', ''
    expect(gh.subtask_text(task_hash)).to eq('')
  end

  it 'leaves out empty comment lists' do
    task_hash = {
      comments: []
    }
    gh = WunderlistToGithub::GitHubSink.new '', ''
    expect(gh.comment_text(task_hash)).to eq('')
  end

  it 'leaves out nil notes' do
    task_hash = {
      note: nil
    }
    gh = WunderlistToGithub::GitHubSink.new '', ''
    expect(gh.note_text(task_hash)).to eq('')
  end

  it 'leaves out nil subtask lists' do
    task_hash = {
      subtasks: nil
    }
    gh = WunderlistToGithub::GitHubSink.new '', ''
    expect(gh.subtask_text(task_hash)).to eq('')
  end

  it 'leaves out nil comment lists' do
    task_hash = {
      comments: nil
    }
    gh = WunderlistToGithub::GitHubSink.new '', ''
    expect(gh.comment_text(task_hash)).to eq('')
  end
end
