require 'yaml'

module Trello
  class Auth
    attr_reader :key, :token

    def initialize(path = nil)
      if path.nil?
        path = File.join(Dir.home, ".trello_auth_sprint_info.yml")
      end
      read_auth_file(path)
    end

    private

    def read_auth_file(path)
      auth = YAML.load_file(path)
      @key = auth[:public_key]
      @token = auth[:token]
    end
  end
end
