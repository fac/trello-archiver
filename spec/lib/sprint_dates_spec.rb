require 'spec_helper'

describe SprintDate do
  let(:last_day_of_sprint) { Date.new(2019, 4, 28) }
  let(:first_day_of_new_sprint) { Date.new(2019, 4, 29) }
  let(:start_last_sprint) { Date.new(2019, 4, 15) }

  context "when calculating the sprint dates for the current sprint" do
    let(:config) { Config::Sprint.new("length" => 2, "starts" => "monday") }

    before do
      Timecop.freeze(last_day_of_sprint)
    end

    subject(:sprint_date) { SprintDate.new(config) }

    it "calculates the start of the sprint" do
      expect(sprint_date.start_date).to eql start_last_sprint
      expect(sprint_date.end_date).to eql last_day_of_sprint
    end
  end

  context "when calculating the sprint dates for the previous sprint" do
    let(:config) { Config::Sprint.new("length" => 2, "starts" => "monday", "previous" => 1) }

    before do
      Timecop.freeze(first_day_of_new_sprint)
    end

    subject(:sprint_date) { SprintDate.new(config) }

    it "calculates the start of the sprint" do
      expect(sprint_date.start_date).to eql start_last_sprint
      expect(sprint_date.end_date).to eql last_day_of_sprint
    end
  end

  context "#to_s" do
    let(:config) { Config::Sprint.new("length" => 2, "starts" => "monday") }

    before do
      Timecop.freeze(last_day_of_sprint)
    end

    subject(:sprint_date) { SprintDate.new(config) }


    it "formats the output date" do
      expect(sprint_date.to_s).to eql "15th Apr - 28th Apr"
    end
  end
end
