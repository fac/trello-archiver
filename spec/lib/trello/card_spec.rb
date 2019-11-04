require 'spec_helper'

describe Trello::Card do
  let(:card_data) do
    {
      "dateLastActivity"=>"2019-03-04T12:38:19.254Z",
      "name"=>"Stripe auto-reconciliation investigation",
      "shortLink"=>"F3Sj1lcw",
      "idMembers"=>["5abe0419bd770fe51d9bd476"],
      "labels"=> [
        {
          "id"=>"5c73dfef88a0747376e384cd",
          "idBoard"=>"5bade24c8194ba1e9b88bbe6",
          "name"=>"Investigation",
          "color"=>"black"
        }
      ],
      "shortLink"=>"F3Sj1lcw",
      "shortUrl"=>"https://trello.com/c/F3Sj1lcw",
      "url"=>"https://trello.com/c/F3Sj1lcw/239-stripe-auto-reconciliation-investigation"
    }
  end
  let(:config) do
    Config::Trello.new({
      "list_id" => "abc1234",
      "blocked_column_id" => "1234abcde",
      "started_column_id" => "a1b2c3d4"
    })
  end

  context "when getting the started at date" do
    context "and the card was created in progress" do
      let(:trello_api) { FakeTrelloApi.new(FakeTrelloApi.card_activity_created_in_progress(config), config) }

      subject(:card) { Trello::Card.new(card_data, trello_api, config) }

      it "returns the date the card was created in progress" do
        expect(card.started_at).to eql DateTime.parse("2019-02-21T10:00:12.682Z")
      end
    end
  end

  context "when getting the duration the card was blocked for" do
		let(:trello_api) { FakeTrelloApi.new(FakeTrelloApi.card_activity_blocked_multiple(config), config) }

		subject(:card) { Trello::Card.new(card_data, trello_api, config) }

		it "returns the date the card was created in progress" do
			expect(card.blocked_duration).to eql 9
		end
  end

  context "when calculating the card duration" do
    context "and the card was created in in progress" do
      let(:trello_api) { FakeTrelloApi.new(FakeTrelloApi.card_activity_created_in_progress(config), config) }

      subject(:card) { Trello::Card.new(card_data, trello_api, config) }

      it "calculates the date from when the card was created" do
        duration = card.duration

        expect(duration).to eql 5
      end
    end

    context "and the card was created in planned" do
      let(:trello_api) { FakeTrelloApi.new(FakeTrelloApi.card_activity_created_in_planned(config), config) }

      subject(:card) { Trello::Card.new(card_data, trello_api, config) }

      it "calculates the duration from when the card entered planned" do
        duration = card.duration

        expect(duration).to eql 3
      end
    end

    context "and the card was created in celebrate" do
      let(:trello_api) { FakeTrelloApi.new(FakeTrelloApi.card_activity_created_in_celebrate(config), config) }

      subject(:card) { Trello::Card.new(card_data, trello_api, config) }

      it "returns a duration of 1" do
        duration = card.duration

        expect(duration).to eql 0
      end
    end

    context "and the card was never in progress" do
      let(:trello_api) { FakeTrelloApi.new(FakeTrelloApi.card_activity_was_never_in_progress(config), config) }

      subject(:card) { Trello::Card.new(card_data, trello_api, config) }

      it "returns a duration of 1" do
        duration = card.duration

        expect(duration).to eql 0
      end
    end

    context "and the card was started and ended on the same day" do
      let(:trello_api) { FakeTrelloApi.new(FakeTrelloApi.card_started_and_finished_on_same_day(config), config) }

      subject(:card) { Trello::Card.new(card_data, trello_api, config) }

      it "returns a duration of 1" do
        duration = card.duration

        expect(duration).to eql 1
      end
    end
  end
end
