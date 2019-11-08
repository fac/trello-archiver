require 'spec_helper'

describe Processors::UnplannedTasks do
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

    unplanned_tasks = described_class.new(nil, writer, trello_api)

    lines = unplanned_tasks.lines
    expect(lines.length).to eql 1
    expect(lines.first.data[0]).to eql "2019-10-31"
    expect(lines.first.data[1]).to eql "[1d] send_new_invoice_emails Recurring Invoice sync issue"
    expect(lines.first.data[2]).to eql "Colin Gemmell, Colin Gemmell"
    expect(lines.first.data[3]).to eql "Unplanned"
    expect(lines.first.data[4]).to eql "https://trello.com/c/Ks018zJG/642-1d-sendnewinvoiceemails-recurring-invoice-sync-issue"
  end
end
