require 'spec_helper'

describe Processors::CompletedTasks do
  let(:config) do
    Config::Trello.new({
      "list_id" => "abc1234",
      "blocked_column_id" => "1234abcde",
      "started_column_id" => "a1b2c3d4"
    })
  end

  it "creates the output lines for the card" do
    writer = FakeWriter.new
    trello_api = FakeTrelloApi.new(config)

    completed_tasks = described_class.new(nil, writer, trello_api)

    lines = completed_tasks.lines
    expect(lines.length).to eql 2
    expect(lines.first.data[0]).to eql "Stripe auto-reconciliation investigation"
    expect(lines.first.data[1]).to eql "Colin Gemmell"
    expect(lines.first.data[2]).to eql "Investigation"
    expect(lines.first.data[3]).to eql "2019-02-21"
    expect(lines.first.data[4]).to eql "2019-02-26"
    expect(lines.first.data[5]).to eql "5"
    expect(lines.first.data[6]).to eql 0
    expect(lines.first.data[7]).to eql "https://trello.com/c/F3Sj1lcw/239-stripe-auto-reconciliation-investigation"
  end
end
