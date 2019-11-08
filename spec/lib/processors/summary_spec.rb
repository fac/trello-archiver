require 'spec_helper'

describe Processors::Summary do
  let(:config) do
    Config::Trello.new({
      "list_id" => "abc1234",
      "blocked_column_id" => "1234abcde",
      "started_column_id" => "a1b2c3d4"
    })
  end

  it "creates the output lines for the summary" do
    sprint_date = "24th Jan - 23 Feb"
    writer = FakeWriter.new
    trello_api = FakeTrelloApi.new(config)
    expected_data = ["24th Jan - 23 Feb", 2, 1, 0, 0, 1]

    summary = described_class.new(sprint_date, writer, trello_api)
    summary.write

    expect(writer.name).to eq Processors::Summary::NAME
    expect(writer.headers).to eq Processors::Summary::HEADERS
    expect(writer.lines.size).to eq 1
    expect(writer.lines.first.data).to eq expected_data
  end
end
