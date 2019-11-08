require 'spec_helper'

class TestClass
  include Processors::CardCategories
end

describe Processors::CardCategories do

  let(:bug_card) { double :bug_card, labels: ["Bug"] }
  let(:unplanned_card) { double :unplanned_card, labels: ["Unplanned"] }
  let(:maintenance_card) { double :maintenance_card, labels: ["Maintenance"] }

  subject { TestClass.new }

  describe "#unplanned?" do
    it "returns true if card is labelled as unplanned" do
      expect(subject.unplanned?(unplanned_card)).to eq true
    end

    it "returns false if card is not labelled as unplanned" do
      expect(subject.unplanned?(bug_card)).to eq false
    end
  end

  describe "#bug?" do
    it "returns true if card is labelled as bug" do
      expect(subject.bug?(bug_card)).to eq true
    end

    it "returns false if card is not labelled as unplanned" do
      expect(subject.bug?(unplanned_card)).to eq false
    end
  end

  describe "#maintenance?" do
    it "returns true if card is labelled as maintenance" do
      expect(subject.maintenance?(maintenance_card)).to eq true
    end

    it "returns false if card is not labelled as unplanned" do
      expect(subject.maintenance?(unplanned_card)).to eq false
    end
  end

  describe "#labelled_as" do
    it "returns true if card has label matching given label" do
      expect(subject.labelled_as(bug_card, "Bug")).to eq true
    end

    it "returns true if card doesn't have label matching given label" do
      expect(subject.labelled_as(bug_card, "Unplanned")).to eq false
    end
  end

  describe "#filter_unplanned" do
    it "returns list of cards which have unplanned label" do
      cards = [bug_card, unplanned_card, maintenance_card]

      expect(subject.filter_unplanned(cards)).to eq [unplanned_card]
    end
  end
end
