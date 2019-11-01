module Processors
  module CardCategories
    def unplanned?(card)
      labelled_as(card, "Unplanned")
    end

    def bug?(card)
      labelled_as(card, "Bug")
    end

    def maintenance?(card)
      labelled_as(card, "Maintenance")
    end

    def labelled_as(card, label)
      card.labels.any? { |applied_label| applied_label.downcase == label.downcase }
    end

    def filter_unplanned(cards)
      cards.select { |card| unplanned?(card) }
    end
  end
end
