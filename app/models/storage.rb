require_relative '../../lib/features/model'

class Storage < ChainDb::Features::Model
  attr_accessor :name, :address, :doc_id

  def initialize(name: '', address: '', doc_id: nil, table_name: nil)
    # table name for the model
    @table_name = table_name || 'storages'

    # table data
    @table_data = {
      doc_id: doc_id,
      name: name,
      address: address
    }

    # initialize the model
    super()
  end
end
