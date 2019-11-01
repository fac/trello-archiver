module Processors
  class Summary
    KEY_COLUMN = "Sprint Dates"
    HEADERS = [KEY_COLUMN, "Completed", "Unplanned", "Bug", "Maintenance", "Feature"]
    NAME = "Overview"

    include CardCategories

    def initialize(sprint_date, writer, trello_api)
      @sprint_date = sprint_date
      @cards = trello_api.cards
      @writer = writer
    end

    def write
      @writer.write(NAME, lines, headers: HEADERS)
    end

    private

    def lines
      no_cards_completed = @cards.length
      unplanned_cards = @cards.select { |card| unplanned?(card) }.length
      bug_cards = @cards.select { |card| bug?(card) }.length
      maintenance_cards = @cards.select { |card| maintenance?(card) }.length
      feature_cards = @cards.reject { |card| unplanned?(card) }
                           .reject { |card| bug?(card) }
                           .reject { |card| maintenance?(card) }.length


      overview_rows = []
      overview_rows << Line.new(KEY_COLUMN, @sprint_date.to_s, [@sprint_date.to_s, no_cards_completed, unplanned_cards, bug_cards, maintenance_cards, feature_cards])
    end
  end
end
