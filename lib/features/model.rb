require_relative 'constants'
require_relative 'utils'

module ChainDb::Features
  class Model
    attr_accessor :table_data, :table_name

    def initialize
      # INFO: These are set by the class that inherits this model
      # @table_name = ''
      # @table_data = {}

      # iterates over the table data and sets the instance variables
      @table_data.each do |key, value|
        instance_variable_set("@#{key}", value)
      end

      @chain_db_instance = Config.get_config(:chain_db_instance)
    end

    # get the history of the table
    def get_history(limit = 25)
      uri = "#{@chain_db_instance.server}#{Constants.GET_HISTORY(@table_name, limit)}"
      response = Utils.get_request(uri, @chain_db_instance.auth)

      # puts response.parsed_response

      raise response.parsed_response['message'] unless response.parsed_response['success']

      response.parsed_response['data']
    end

    # persist the current doc. if doc_id is not present, a new document will be created. if doc_id is present, the document will be updated.
    def persist
      # sync the current doc with the instance variables
      sync_table_data_with_instance_variables

      uri = if @table_data[:doc_id].nil?
              "#{@chain_db_instance.server}#{Constants.PERSIST_NEW_DATA(@table_name)}"
            else
              "#{@chain_db_instance.server}#{Constants.UPDATE_ITEM(@table_name)}"
            end

      response = if @table_data[:doc_id].nil?
                   # send new data excluding doc_id (it comes from the database)
                   Utils.post_request(uri, @chain_db_instance.auth, { data: @table_data.except(:doc_id) })
                 else
                   # update data excluding doc_id (it comes from the database)
                   puts "current doc: #{@table_data}"
                   Utils.post_request(uri, @chain_db_instance.auth,
                                      { data: @table_data.except(:doc_id), doc_id: @table_data[:doc_id] })
                 end

      raise response.parsed_response['message'] unless response.parsed_response['success']

      result = response.parsed_response['data']

      # iterates over the result and sets the instance variables
      # updates the instance variables only if the key is present in the table_data or if the key is 'doc_id'
      # result.each do |key, value|
      #   instance_variable_set("@#{key}", value) if @table_data.key?(key) || key == 'doc_id'
      # end

      # set the doc_id provided by the database
      self.doc_id = result['doc_id']
      @table_data[:doc_id] = result['doc_id']

      self
    end

    # get data from the table by criteria
    def find_where(criteria: {}, limit: 1000, reverse: true)
      uri = "#{@chain_db_instance.server}#{Constants.FIND_WHERE_BASIC(@table_name)}"
      response = Utils.post_request(uri, @chain_db_instance.auth,
                                    { criteria: criteria, limit: limit, reverse: reverse })

      raise response.parsed_response['message'] unless response.parsed_response['success']

      response.parsed_response['data']
    end

    # get data from the table by advanced criteria
    def find_where_advanced(criteria: [], limit: 1000, reverse: true)
      return [] if criteria.empty?

      uri = "#{@chain_db_instance.server}#{Constants.FIND_WHERE_ADVANCED(@table_name)}"
      response = Utils.post_request(uri, @chain_db_instance.auth,
                                    { criteria: criteria, limit: limit, reverse: reverse })

      raise response.parsed_response['message'] unless response.parsed_response['success']

      response.parsed_response['data']
    end

    # get the last item from the table
    def last
      uri = "#{@chain_db_instance.server}#{Constants.GET_TABLE(@table_name)}"
      response = Utils.get_request(uri, @chain_db_instance.auth)

      raise response.parsed_response['message'] unless response.parsed_response['success']

      response.parsed_response['data']
    end

    # get data from the table by doc_id
    def by_doc_id(doc_id)
      uri = "#{@chain_db_instance.server}#{Constants.GET_DOC(@table_name, doc_id)}"
      response = Utils.get_request(uri, @chain_db_instance.auth)

      raise response.parsed_response['message'] unless response.parsed_response['success']

      response.parsed_response['data']
    end

    # convert the current doc to a hash
    def to_h
      @table_data.transform_keys(&:to_sym)
    end

    # get the last item from the table
    def self.last
      to_model(new.last)
    end

    # get data from the table by doc_id
    def self.by_doc_id(doc_id)
      to_model(new.by_doc_id(doc_id))
    end

    # get all data from the table
    def self.all(limit = 25)
      to_models(new.get_history(limit))
    end

    # get all data from the table by criteria
    def self.all_where(criteria: {}, limit: 1000, reverse: true)
      to_models(new.find_where(criteria: criteria, limit: limit, reverse: reverse))
    end

    # get data from the table by advanced criteria
    def self.all_where_advanced(criteria: [], limit: 1000, reverse: true)
      to_models(new.find_where_advanced(criteria: criteria, limit: limit, reverse: reverse))
    end

    # get data from the table by criteria
    def self.where(criteria: {})
      to_model(new.find_where(criteria: criteria, limit: limit)[0])
    end

    # get data from the table by advanced criteria
    def self.where_advanced(criteria: [], limit: 1000, reverse: true)
      to_model(new.find_where_advanced(criteria: criteria, limit: limit, reverse: reverse)[0])
    end

    # convert the data to model
    def self.to_models(data)
      data.map { |item| to_model(item) }
    end

    # convert the data to model
    def self.to_model(data)
      new(**data.transform_keys(&:to_sym))
    end

    private

    # def fetch
    #   uri = "#{@chain_db_instance.server}#{Constants.GET_TABLE(@table_name)}"
    #   response = Utils.get_request(uri, @chain_db_instance.auth)

    #   raise response.parsed_response['message'] unless response.parsed_response['success']

    #   response.parsed_response['data']
    # end

    # sync the table data with the instance variables
    def sync_table_data_with_instance_variables
      updated_table_data = {}

      # must iterate over the instance variables and set the current doc with the values only if the key is present in the current doc
      instance_variables.each do |var|
        key = var.to_s.delete('@').to_sym
        value = instance_variable_get(var)
        # only set the value if the key is present in the current doc
        updated_table_data[key] = value if @table_data.key?(key)
      end

      @table_data = updated_table_data
    end
  end
end
