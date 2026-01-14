module ChainDb::Features
  module Utils
    def self.get_request(uri, auth)
      HTTParty.get(uri, headers: { Authorization: "Basic #{auth}", 'content-Type' => 'application/json' })
    end

    def self.post_request(uri, auth, body)
      HTTParty.post(uri, headers: { Authorization: "Basic #{auth}", 'content-Type' => 'application/json' },
                         body: body.to_json)
    end

    # build the criteria for the advanced_find_where method
    def self.build_criteria(field: '', operator: Operators::EQUAL, value: nil)
      return nil if value.nil?

      {
        field: field,
        operator: operator,
        value: value
      }
    end
  end
end
