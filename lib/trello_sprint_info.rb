require_relative './config'
require_relative './processors/processors'
require_relative './outputs/outputs'
require_relative './trello/trello'
require_relative './sprint_date'

class TrelloSprintInfo
  def initialize(sprint_date, writer, trello_api)
    @sprint_date = sprint_date
    @writer = writer
    @trello_api = trello_api
  end

  def self.run(opts)
    config = Config.new
    trello_api = Trello::Api.new(Trello::Auth.new, config.trello)
    writer = case opts[:writer]
    when :gdoc
      Outputs::GoogleSpreadsheet.new(config.gdoc)
    else
      Outputs::Console.new
    end
    sprint_date = SprintDate.new(config.sprint.merge!(opts[:sprint]))
    new(sprint_date, writer, trello_api).execute
  end

  def execute
    [Processors::Summary, Processors::UnplannedTasks, Processors::CompletedTasks].each do |processor|
      processor.new(@sprint_date, @writer, @trello_api).write
    end
  end
end
