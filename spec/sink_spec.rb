# frozen_string_literal: true
require 'spec_helper'
require 'wunderlist'
require 'wunderlist_to_github/sink'

RSpec.describe WunderlistToGithub::GitHubSink do
  it 'converts tasks to hashes' do
    task = instance_double(Wunderlist::Task)
    note = instance_double(Wunderlist::Note)
    task_comment = instance_double(Wunderlist::TaskComment)
    subtask = instance_double(Wunderlist::Subtask)
    allow(note).to receive_messages(
      content: 'Note content'
    )
    allow(task_comment).to receive_messages(
      text: 'Comment text'
    )
    allow(subtask).to receive_messages(
      title: 'Subtask title'
    )
    allow(task).to receive_messages(
      title: 'A title',
      completed: true,
      note: note,
      task_comments: [task_comment],
      subtasks: [subtask]
    )
    gh = WunderlistToGithub::GitHubSink.new '', ''
    task_hash = gh.convert_task_to_hash(task)
    expect(task_hash[:title]).to eq('A title')
    expect(task_hash[:completed]).to eq(true)
    expect(task_hash[:note]).to eq('Note content')
    expect(task_hash[:comments][0]).to eq('Comment text')
    expect(task_hash[:subtasks][0]).to eq('Subtask title')
  end

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
end