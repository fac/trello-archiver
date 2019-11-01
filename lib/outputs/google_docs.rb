require 'google/apis/sheets_v4'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

module Outputs
  class GoogleSpreadsheet
    OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
    APPLICATION_NAME = 'workflow-completed-work'.freeze
    CREDENTIALS_PATH = File.join(Dir.home, '.gdoc_credentials.json').freeze

    # The file token.yaml stores the user's access and refresh tokens, and is
    # created automatically when the authorization flow completes for the first
    # time.
    TOKEN_PATH = File.join(Dir.home, '.gdoc_token.yml').freeze
    SCOPE = Google::Apis::SheetsV4::AUTH_SPREADSHEETS

    def initialize(config)
      @config = config
      @service = create_service
    end

    def write(name, lines, headers=[])
      header_range = "#{name}!A1:Z"
      response = @service.get_spreadsheet_values(@config.spreadsheet_id, header_range)
      current_values = response.values
      headers = current_values.shift

      lines = lines.reject do |line|
        header_idx = headers.index(line.key_column)
        current_values.any? {|values| values[header_idx] == line.key }
      end

      range = "#{name}!A2"
      values = lines.map(&:data)
      unless values.empty?
        value_range_object = Google::Apis::SheetsV4::ValueRange.new(range_name: 'range', values: values)
        @service.append_spreadsheet_value(@config.spreadsheet_id, range, value_range_object, value_input_option: "RAW")
      end
    end

    private

    def create_service
      service = Google::Apis::SheetsV4::SheetsService.new
      service.client_options.application_name = APPLICATION_NAME
      service.authorization = authorize
      service
    end

    def authorize
      return @credentials unless @credentials.nil?
      client_id = Google::Auth::ClientId.from_file(CREDENTIALS_PATH)
      token_store = Google::Auth::Stores::FileTokenStore.new(file: TOKEN_PATH)
      authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
      user_id = 'default'
      credentials = authorizer.get_credentials(user_id)
      if credentials.nil?
        url = authorizer.get_authorization_url(base_url: OOB_URI)
        puts 'Open the following URL in the browser and enter the ' \
             "resulting code after authorization:\n" + url
        code = gets
        credentials = authorizer.get_and_store_credentials_from_code(
          user_id: user_id, code: code, base_url: OOB_URI
        )
      end
      @credentials = credentials
    end
  end
end
