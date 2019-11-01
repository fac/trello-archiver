module Processors
  class Line
    attr_reader :key_column, :key, :data

    def initialize(key_column, key, data)
      @key_column = key_column
      @key = key
      @data = data
    end
  end
end
