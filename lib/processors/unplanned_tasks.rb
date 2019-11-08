module Processors
  class UnplannedTasks
    NAME = "Unplanned Work"
    KEY_COLUMN = "Url"
    HEADERS = ["Completed Date", "Name", "Authors", "Labels", "Url"]

    include CardCategories

    def initialize(_, writer, trello_api)
      @cards = trello_api.cards
      @writer = writer
      @trello_api = trello_api
    end

    def lines
      filter_unplanned(@cards).map do |card|
        Line.new(KEY_COLUMN, card.url, [
          card.last_activity_date.strftime("%Y-%m-%d"),
          card.name,
          card.authors.join(", "),
          card.labels.join(', '),
          card.url
        ])
      end
    end

    def write
      @writer.write(NAME, lines, headers: HEADERS)
    end

    private

    def fetch_member(member_id)
      @trello_api.fetch_member(member_id)
    end
  end
end
