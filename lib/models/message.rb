require_relative '../features/model'

module Models
  class Message < ChainDb::Features::Model
    # table data props + doc_id (always present)
    attr_accessor :username, :message, :b64Image, :timestamp, :doc_id

    # table props
    # INFO: table props should come first
    # INFO: must always have doc_id, table_name can be fixed or passed as a parameter
    def initialize(username: '', message: '', b64Image: '', timestamp: nil, doc_id: nil, table_name: nil)
      # table name for the model
      @table_name = table_name || 'messages-weather'

      # table data
      @table_data = {
        doc_id: doc_id,
        username: username,
        message: message,
        b64Image: b64Image,
        timestamp: timestamp || (Time.now.to_f * 1000).to_i
      }

      # initialize the model
      super()
    end
  end
end
