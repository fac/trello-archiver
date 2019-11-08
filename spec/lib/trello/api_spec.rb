require 'spec_helper'

describe Trello::Api do
  let(:auth) { double :trello_auth, key: 'abcde', token: 'edcba' }
  let(:config) { double :config, list_id: '1234', blocked_column_id: '2345', started_column_id: '3456' }

  subject { Trello::Api.new(auth, config) }

  describe "#cards" do
    let(:cards_api_response) {
      [
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
        },
        {
          "dateLastActivity"=>"2019-10-31T12:19:34.376Z",
          "name"=>"[1d] send_new_invoice_emails Recurring Invoice sync issue",
          "shortLink"=>"Ks018zJG",
          "idMembers"=> ["5abe0419bd770fe51d9bd476", "5d9b05bc19093439cd980ba3"],
          "labels"=> [
            {
              "id"=>"5c053846c1c0050bb90329a6",
              "idBoard"=>"5bade24c8194ba1e9b88bbe6",
              "name"=>"Unplanned",
              "color"=>"blue"
            }
          ],
          "shortUrl"=>"https://trello.com/c/Ks018zJG",
          "subscribed"=>true,
          "url"=>"https://trello.com/c/Ks018zJG/642-1d-sendnewinvoiceemails-recurring-invoice-sync-issue"
        }
      ].to_json
    }

    it 'fetches the cards from trello based on the list id' do
      uri = URI("#{Trello::Api::BASE_URI}/lists/1234/cards?fields=all&key=#{auth.key}&token=#{auth.token}")
      allow(Net::HTTP).to receive(:get).with(uri).and_return cards_api_response

      cards = subject.cards
      expect(cards.length).to eq 2
    end
  end

  describe "#card activity" do
    let(:card_activity_response) do
      [
        {
          "data" => {
            "list" => {
              "name" => "Celebrate 🎉",
              "id" => config.list_id
            },
          },
          "type" => "createCard",
          "date" => "2019-02-21T10:00:12.682Z",
        }
      ].to_json
    end

    it "fetches the card activity based on the card link" do
      uri = URI("#{Trello::Api::BASE_URI}/cards/Ks018zJG/actions?fields=all&key=#{auth.key}&token=#{auth.token}&filter=createCard,updateCard")
      allow(Net::HTTP).to receive(:get).with(uri).and_return card_activity_response

      card_activity = subject.card_activity("Ks018zJG")
      expect(card_activity).to eq JSON.parse(card_activity_response)
    end
  end

  describe "#fetch_member" do
    let(:member_response) do
      {
        "id":"5d9b05bc19093439cd980ba3",
        "activityBlocked":false,
        "avatarHash":"adb185eaaecf932f88e3f260bd5c3272",
        "avatarUrl":"https://trello-avatars.s3.amazonaws.com/adb185eaaecf932f88e3f260bd5c3272",
        "bio":"",
        "confirmed":true,
        "fullName":"Anna Whittingham",
        "idEnterprise":nil,
        "initials":"AW",
        "memberType":"normal",
        "username":"annawhittingham1"
      }.to_json
    end

    it "fetches the information for a given member" do
      uri = URI("#{Trello::Api::BASE_URI}/members/5d9b05bc19093439cd980ba3?fields=all&key=#{auth.key}&token=#{auth.token}")
      allow(Net::HTTP).to receive(:get).with(uri).and_return member_response

      member = subject.fetch_member("5d9b05bc19093439cd980ba3")
      expect(member).to eq "Anna Whittingham"
    end
  end
end
