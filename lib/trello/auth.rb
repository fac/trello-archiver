require 'yaml'
require 'trello'

module Trello
  class Auth
    attr_reader :key, :token

    def initialize(path = nil)
      if path.nil?
        path = File.join(Dir.home, ".trello_auth_sprint_info.yml")
      end
      read_auth_file(path)
    end

    def self.configure_trello_authentication
      authenticate_trello
    end

    def self.authenticate_trello
      public_key = get_public_key
      token = get_token(public_key)
      trello_auth_path = File.join(Dir.home, ".trello_auth_sprint_info_test.yml")

      File.open(trello_auth_path, 'w') do |file|
        file.write(
          YAML.dump({"public_key" => public_key, "token" => token})
        )
      end
      puts "Trello credentials writen to #{ trello_auth_path }"
    end
    private_class_method :authenticate_trello

    def self.get_public_key
      puts "Trello authentication required"
      puts "Visit the url below to get your api key and paste in the prompt"
      puts "https://trello.com/app-key"
      print "Enter API Key: "
      STDIN.gets.strip
    end
    private_class_method :get_public_key

    def self.get_token(public_key)
      auth_url = Trello.authorize_url(key: public_key, name: "Freeagent Trello Archiver").to_s
      puts "Visit the url below to authorise the app and paste the generated token at the prompt"
      puts auth_url
      print "Enter Token: "
      STDIN.gets.strip
    end
    private_class_method :get_token

    private

    def read_auth_file(path)
      auth = YAML.load_file(path)
      @key = auth[:public_key]
      @token = auth[:token]
    end
  end
end
