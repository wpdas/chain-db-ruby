require_relative '../../lib/features/model'

class Message < ChainDb::Features::Model
  attr_accessor :username, :message, :b64Image, :timestamp, :doc_id

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
