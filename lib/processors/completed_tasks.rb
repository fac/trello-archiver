module Processors
  class CompletedTasks
    NAME = "Completed Cards"
    KEY_COLUMN = "Url"
    HEADERS = ["Name", "Authors", "Labels", "Started At", "Completed At", "Duration", "Blocked duration", KEY_COLUMN]

    include CardCategories

    def initialize(sprint_date, writer, trello_api)
      @sprint_date = sprint_date
      @cards = trello_api.cards
      @writer = writer
      @trello_api = trello_api
    end

    def lines
      @cards.map do |card|
        Line.new(KEY_COLUMN, card.url, [
          card.name,
          card.authors.join(", "),
          card.labels.join(", "),
          card.started_at.nil? ? "" : card.started_at.strftime("%Y-%m-%d"),
          card.completed_at.strftime("%Y-%m-%d"),
          card.duration.to_s,
          card.blocked_duration,
          card.url
        ])
      end
    end

    def write
      @writer.write(NAME, lines, headers: HEADERS)
    end
  end
end
