require "active_support/core_ext/date"
require "active_support/core_ext/integer"

class SprintDate
  attr_reader :start_date, :end_date

  def initialize(config)
    @start_date = if config.previous != 0
      Date.today.beginning_of_week(config.starts.to_sym) - (config.previous * config.length).weeks
    else
      Date.today.next_week.beginning_of_week(config.starts.to_sym) - config.length.weeks
    end
    @end_date = (@start_date + config.length.weeks) - 1.day
  end

  def to_s
    "#{date_format(@start_date)} - #{date_format(@end_date)}"
  end

  private

  def date_format(date)
    date.strftime("#{ date.day.ordinalize } %b")
  end
end
