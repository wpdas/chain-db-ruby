require 'httparty'
require 'json'

require_relative 'constants'

$chain_db_instance = nil

module ChainDb::Features
  module Config
    @config = {}

    def self.set_config(key, value)
      @config[key] = value
    end

    def self.get_config(key)
      @config[key]
    end
  end

  class Connection
    attr_accessor :server, :database, :auth

    @server = Constants::DEFAULT_API_SERVER

    def connect(server, database, user, password)
      @server = server if server
      @database = database

      # puts "#{@server}#{Constants.CONNECT}"

      uri = "#{@server}#{Constants.CONNECT}"
      body = { name: @database, user: user, password: password }.to_json
      headers = { 'Content-Type' => 'application/json' }
      response = HTTParty.post(uri, body: body, headers: headers)

      raise response.parsed_response['message'] unless response.parsed_response['success']

      # puts response.code # e.g., 201
      # puts response.body # The response body
      # puts response.parsed_response # Auto-parsed body (e.g., a Hash)

      # puts response.body

      @auth = response.parsed_response['data']
      # response.body

      # set safely the global instance
      Config.set_config(:chain_db_instance, self)
    end
  end
end
