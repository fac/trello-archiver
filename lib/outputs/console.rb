require 'terminal-table'

module Outputs
  class Console
    def write(name, lines, headers: [])
      puts "**#{name}**"
      data = lines.map(&:data)
      if headers.length > 0
        data.unshift(headers)
      end
      puts Terminal::Table.new(rows: data)
      puts ""
    end
  end
end
