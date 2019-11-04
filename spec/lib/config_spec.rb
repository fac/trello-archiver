require 'spec_helper'

describe Config do
  context "when the sprint config is set" do
    let(:config) { Config.new(File.join(Dir.pwd, 'spec/support/trello_sprint_test_config.yml')) }

    it "reads the config and sets the trello configured values" do
      expect(config.trello.list_id).to eq "list id"
      expect(config.trello.blocked_column_id).to eq "blocked id"
      expect(config.trello.started_column_id).to eq "started id"
    end

    it "reads the config and sets the trello configured values" do
      expect(config.gdoc.spreadsheet_id).to eq "spreadsheet id"
    end

    context "when the sprint config is set" do
      it "sets fields using configured values" do
        expect(config.sprint.length).to eq 4
        expect(config.sprint.starts).to eq "tuesday"
        expect(config.sprint.previous).to eq 1
      end
    end
  end

  context "when the sprint config is not set" do
    let(:config) { Config.new(File.join(Dir.pwd, 'spec/support/trello_test_no_sprint_config.yml')) }

    it "sets the fields using default values" do
      expect(config.sprint.length).to eq 2
      expect(config.sprint.starts).to eq "monday"
      expect(config.sprint.previous).to eq 0
    end
  end
end
