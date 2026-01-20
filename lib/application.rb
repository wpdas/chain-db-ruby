# frozen_string_literal: true

module ChainDb; end
module ChainDb::Features; end

require_relative 'features/chain_db'
require_relative 'features/utils'
require_relative 'features/operators'
require_relative 'config/environment'
require_relative '../app/models/message'
require_relative '../app/models/product'
require_relative '../app/models/storage'

# Classe principal da aplicação
class Application
  def initialize
    @running = true
  end

  def run
    chain_db = ChainDb::Features::Connection.new
    chain_db.connect('https://gull-dominant-mistakenly.ngrok-free.app', 'chat-app-db', 'root', 'chat-db-#z7e185yH4')
    # puts chain_db.auth

    # storage example
    store_name = 'BH Store'

    current_storage = Storage.where(criteria: { name: store_name })
    if current_storage.nil?
      storage1 = Storage.new(name: store_name, address: 'Rua Xyz, 60').persist
      prod1 = Product.new(storage_id: storage1.doc_id, name: 'PS5', description: 'Best Console ever',
                          price: 30_000).persist
      puts prod1.to_hash
    else
      # puts current_storage.to_hash
      # puts current_storage.doc_id

      # puts Product.new(storage_id: current_storage.doc_id, name: 'Vinho', description: 'The best wine',
      #                  price: 1200).persist.to_hash

      # puts Product.new(storage_id: current_storage.doc_id, name: 'Carrinho de Bebe', description: 'Carrinho top',
      #                  price: 60_000).persist.to_hash

      # puts Product.new(storage_id: current_storage.doc_id, name: 'Smart Phone XS', description: 'O mais top das galáxias',
      #                  price: 101_000).persist.to_hash

      puts "Produtos da loja: #{current_storage.name}"
      Product.all_where(criteria: { storage_id: current_storage.doc_id }, reverse: false).each do |product|
        puts product.to_hash
      end

      # Product.all.each do |product|
      #   puts product.to_hash
      # end

      # puts "\n"
      # puts Product.last.to_hash
    end

    # puts '== create message =='
    # new_message = Message.new(username: 'Mr. Nobody', message: 'Hello, world!', b64Image: 'https://picsum.photos/200/200')
    # puts new_message.persist.to_hash
    # puts '== create message end =='
    # puts "\n"

    # puts '== get all messages =='
    # Message.all(50).each do |message|
    #   puts message.to_hash
    # end
    # puts '== get all messages end =='
    # puts "\n"

    # puts '== fix all messages without content =='
    # Message.all(50).each do |message|
    #   # puts message.to_hash if message.username.empty?
    #   next unless message.username.empty?

    #   message.username = 'Fix'
    #   message.message = 'This message is fixed :D'
    #   message.persist
    # end
    # puts '== fix all messages without content end =='

    # puts '== get many messages by username =='
    # Message.all_where(criteria: { username: 'Mr. Nobody' }).each do |message|
    #   puts message.to_hash
    # end
    # puts '== get many messages by username end =='
    # puts "\n"

    # puts '== get many messages by username and message contains 3333 =='
    # criteria = [
    #   ChainDb::Features::Utils.build_criteria(field: 'username', operator: ChainDb::Features::Operators::EQUAL,
    #                                           value: 'Mr. Nobody'),
    #   ChainDb::Features::Utils.build_criteria(field: 'message', operator: ChainDb::Features::Operators::CONTAINS,
    #                                           value: '3333')
    # ]
    # puts Message.where_advanced(criteria: criteria).to_hash
    # puts '== get many messages by username and message contains 3333 end =='
    # puts "\n"

    # puts '== get many messages by b64Image contains the picsum url =='
    # criteria = [
    #   # ChainDb::Features::Utils.build_criteria(field: 'username', operator: ChainDb::Features::Operators::EQUAL,
    #   #                                         value: 'Mr. Nobody'),
    #   # ChainDb::Features::Utils.build_criteria(field: 'message', operator: ChainDb::Features::Operators::CONTAINS,
    #   #                                         value: '3333')
    #   ChainDb::Features::Utils.build_criteria(field: 'b64Image', operator: ChainDb::Features::Operators::CONTAINS,
    #                                           value: 'https://picsum.photos')
    # ]
    # Message.all_where_advanced(criteria: criteria).each do |message|
    #   puts message.to_hash
    # end
    # puts '== get many messages by b64Image contains the picsum url end =='
    # puts "\n"

    # puts '== get message by username =='
    # message_data = Message.where(criteria: { username: 'Mr. Nobody' })
    # puts message_data.message
    # puts message_data.to_hash
    # puts '== get message by username end =='
    # puts "\n"

    # puts '== get message by username and update its data =='
    # message_data = Message.where(criteria: { doc_id: 'b30ba45f-175b-4c2e-bc18-4bf6c288b295' })
    # if message_data
    #   puts "message data: #{message_data.nil?}"
    #   puts "original data: #{message_data.to_hash}"
    #   message_data.message = 'Hello, world! Updated 3333'
    #   puts "updated data: #{message_data.persist}"
    # end
    # puts '== get message by username and update its data end =='
    # puts "\n"

    # puts '== get last message =='
    # last_message = Message.last
    # puts "Last data: #{last_message.to_hash}"
    # puts '== get last message end =='
    # puts "\n"

    # puts '== get message by doc_id =='
    # message_data = Message.by_doc_id('b30ba45f-175b-4c2e-bc18-4bf6c288b295')
    # puts "Message data: #{message_data.to_hash}"
    # puts '== get message by doc_id end =='
    # puts "\n"

    # loop to persist a new weather message every 5 seconds
    # puts '== creating new random messages =='
    # puts "\n"
    # loop do
    #   begin
    #     # fetch random text
    #     random_text = HTTParty.get('https://api.chucknorris.io/jokes/random').parsed_response

    #     username = ['Mr. Nobody', 'Chuck Norris', 'Yuppie Noob', 'Leopoldino', 'Tulipete'][rand(0..4)]
    #     picture = [random_text['icon_url'], "https://picsum.photos/#{rand(150..400)}/#{rand(150..400)}"][rand(0..1)]

    #     new_message = Message.new(username: username, message: random_text['value'],
    #                                       b64Image: picture).persist

    #     puts "Success ===> #{new_message.to_hash}"
    #   rescue HTTParty::Error => e
    #     puts "An error occurred: #{e.message}"
    #   end

    #   puts "\n"

    #   sleep(2)
    # end

    # loop do
    #   begin
    #     # fetch random text
    #     random_text = HTTParty.get('https://api.chucknorris.io/jokes/random').parsed_response

    #     messages_table.current_doc = {
    #       username: ['Mr. Nobody', 'Chuck Norris', 'Yuppie Noob', 'Leopoldino', 'Tulipete'][rand(0..4)],
    #       message: random_text['value'],
    #       b64Image: random_text['icon_url'],
    #       # b64Image: 'https://picsum.photos/200/200',
    #       timestamp: (Time.now.to_f * 1000).to_i
    #     }

    #     # persist a new weather message
    #     result = messages_table.persist
    #     puts "Message persisted: #{result}"
    #   rescue HTTParty::Error => e
    #     puts "An error occurred: #{e.message}"
    #   end

    #   sleep(5)
    # end

    #
    # loop do
    #   break unless @running

    #   # Exemplo de loop principal
    #   sleep 1
    # end
  end

  def stop
    @running = false
  end
end
