API_BASE = '/api/v1'
HEADERS = { 'Content-Type' => 'application/json' }

module ChainDb::Features
  module Constants
    DEFAULT_API_SERVER = 'http://localhost:2818'
    def self.CONNECT
      "#{API_BASE}/database/connect"
    end

    def self.GET_TABLE(table)
      "#{API_BASE}/table/#{table}"
    end

    def self.UPDATE_ITEM(table)
      "#{API_BASE}/table/#{table}/update"
    end

    def self.PERSIST_NEW_DATA(table)
      "#{API_BASE}/table/#{table}/persist"
    end

    def self.GET_HISTORY(table, limit = 25)
      "#{API_BASE}/table/#{table}/history?limit=#{limit}"
    end

    def self.FIND_WHERE_BASIC(table)
      "#{API_BASE}/table/#{table}/find"
    end

    def self.FIND_WHERE_ADVANCED(table)
      "#{API_BASE}/table/#{table}/find-advanced"
    end

    def self.GET_DOC(table, doc_id)
      "#{API_BASE}/table/#{table}/doc/#{doc_id}"
    end

    def self.WEB_SOCKET_EVENTS
      "#{API_BASE}/events"
    end
  end
end
