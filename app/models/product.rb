require_relative '../../lib/features/model'

class Product < ChainDb::Features::Model
  attr_accessor :name, :description, :price, :doc_id

  def initialize(storage_id: '', name: '', description: '', price: nil, doc_id: nil, table_name: nil)
    # table name for the model
    @table_name = table_name || 'products'

    # table data
    @table_data = {
      doc_id: doc_id,
      storage_id: storage_id,
      name: name,
      description: description,
      price: price
    }

    # initialize the model
    super()
  end
end
