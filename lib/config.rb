class Config
  attr_reader :trello, :gdoc, :sprint

  def initialize(path = nil)
    if path.nil?
      path = File.join(Dir.pwd, "trello_sprint.yml")
    end
    load_config(path)
  end

  private

  def load_config(path)
    config = YAML.load_file(path)

    @trello = Trello.new(config["trello"])
    @gdoc = Gdoc.new(config["gdoc"])
    @sprint = Sprint.new(config.fetch("sprint", {}))
  end

  class Trello
    attr_reader :list_id, :blocked_column_id, :started_column_id

    def initialize(config)
      @list_id = config.fetch("list_id")
      @blocked_column_id = config.fetch("blocked_column_id")
      @started_column_id = config.fetch("started_column_id")
    end
  end

  class Gdoc
    attr_reader :spreadsheet_id

    def initialize(config)
      @spreadsheet_id = config.fetch("spreadsheet_id")
    end
  end

  class Sprint
    attr_reader :length, :starts, :previous

    def initialize(config)
      @length = config.fetch("length", 2)
      @starts = config.fetch("starts", "monday")
      @previous = config.fetch("previous", 0).to_i
    end

    def merge!(opt)
      @length = opt.fetch(:length, @length)
      @starts = opt.fetch(:starts, @starts)
      @previous = opt.fetch(:previous, @previous)
      self
    end
  end
end
