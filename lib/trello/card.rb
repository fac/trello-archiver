module Trello
  class Card
    def initialize(data, api, config)
      @data = data
      @api = api
      @config = config
    end

    def name
      @name ||= @data.fetch("name")
    end

    def authors
      @authors ||= @data.fetch("idMembers", []).map { |member_id| @api.fetch_member(member_id) }
    end

    def labels
      @labels ||= @data.fetch("labels", []).map { |label| label.fetch("name") }
    end

    def url
      @url ||= @data.fetch("url")
    end

    def short_link
      @short_link ||= @data.fetch("shortLink")
    end

    def last_activity_date
      @last_activity ||= Date.parse(@data.fetch("dateLastActivity", "2019-01-01"))
    end

    require 'pry'
    def blocked_duration
      return @blocked_duration unless @blocked_duration.nil?
      card_activity = @api.card_activity(short_link).reverse
      blocked_activity = card_activity.select do |card|
        card.dig("data", "listAfter", "id") == blocked_column ||
          card.dig("data", "listBefore", "id") == blocked_column
      end
      total_time_blocked = 0
      blocked_activity.each_cons(2) do |first_card, last_card|
        entered_block = DateTime.parse(first_card.fetch("date"))
        left_block = DateTime.parse(last_card.fetch("date"))
        total_time_blocked += (left_block.mjd - entered_block.mjd)
      end
      @blocked_duration = total_time_blocked
    end

    def started_at
      return @started_at unless @started_at.nil?
      card_activity = @api.card_activity(short_link).reverse
      entered_in_progress = card_activity.detect do |activity|
        (activity.fetch("type") == "createCard" &&
          activity.dig("data", "list", "id") == started_column) ||
        (activity.fetch("type") == "updateCard" &&
          activity.dig("data", "listAfter", "id") == started_column)
      end
      return nil if entered_in_progress.nil?
      DateTime.parse(entered_in_progress.fetch("date", "2019-01-01"))
    end

    def completed_at
      return @completed_at unless @completed_at.nil?
      card_activity = @api.card_activity(short_link)
      last_celebrated_at = card_activity.detect do |activity|
        activity.fetch("type") == "updateCard" &&
          activity.dig("data", "listAfter", "id") == celebrate_column
      end
      if last_celebrated_at.nil?
        last_celebrated_at = card_activity.detect do |activity|
          activity.fetch("type") == "createCard" &&
            activity.dig("data", "list", "id") == celebrate_column
        end
        return DateTime.now if last_celebrated_at.nil?
        return @completed_at = DateTime.parse(last_celebrated_at.fetch("date", "2019-01-01"))
      end
      return DateTime.now if last_celebrated_at.nil?
      @completed_at = DateTime.parse(last_celebrated_at.fetch("date", "2019-01-01"))
    end

    def duration
      return 0 if started_at.nil?

      duration = completed_at.mjd - started_at.mjd
      return 1 if duration == 0
      duration
    end

    private

    def celebrate_column
      @config.list_id
    end

    def blocked_column
      @config.blocked_column_id
    end

    def started_column
      @config.started_column_id
    end

  end
end
