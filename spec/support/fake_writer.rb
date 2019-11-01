class FakeWriter
  attr_reader :name, :lines, :headers

  def write(name, lines, headers: [])
    @name = name
    @lines = lines
    @headers = headers
  end
end
