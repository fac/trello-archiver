require 'net/http'
require 'json'

module Trello
  class Api
    BASE_URI="https://api.trello.com/1"

    def initialize(auth, config)
      @auth = auth
      @config = config
      @members = {}
      @card_activity = {}
    end

    def cards
      return @cards unless @cards.nil?

      cards = fetch("/lists/#{@config.list_id}/cards")
      @cards = cards.map{|card| Card.new(card, self) }
    end

    def card_activity(short_link)
      return @card_activity[short_link] unless @card_activity[short_link].nil?

      activity = fetch("/cards/#{short_link}/actions", filters: ["createCard", "updateCard"])

      @card_activity[short_link] = activity
    end

    def fetch_member(member_id)
      return @members[member_id] unless @members[member_id].nil?

      member = fetch("/members/#{member_id}")
      @members[member_id] = member.fetch("fullName")
    end

    private

    def fetch(path, filters: [])
      base_path = "#{BASE_URI}#{path}?fields=all&key=#{@auth.key}&token=#{@auth.token}"
      if !filters.empty?
        base_path += "&filter=#{filters.join(",")}"
      end

      uri = URI(base_path)

      result = Net::HTTP.get(uri)

      JSON.parse(result)
    end
  end
end
