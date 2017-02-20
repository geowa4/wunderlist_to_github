# frozen_string_literal: true
require 'spec_helper'
require 'wunderlist'
require 'wunderlist_to_github/source'

RSpec.describe WunderlistToGithub::WunderlistSource do
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
    wl = WunderlistToGithub::WunderlistSource.new '', ''
    task_hash = wl.convert_task_to_hash(task)
    expect(task_hash[:title]).to eq('A title')
    expect(task_hash[:completed]).to eq(true)
    expect(task_hash[:note]).to eq('Note content')
    expect(task_hash[:comments][0]).to eq('Comment text')
    expect(task_hash[:subtasks][0]).to eq('Subtask title')
  end
end
