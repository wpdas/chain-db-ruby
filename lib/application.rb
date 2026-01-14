# frozen_string_literal: true

module ChainDb; end
module ChainDb::Features; end
module Models; end

require_relative 'features/chain_db'
require_relative 'features/utils'
require_relative 'features/operators'
require_relative 'config/environment'
require_relative 'models/message'

# Classe principal da aplicação
class Application
  def initialize
    @running = true
  end

  def run
    puts 'Aplicação iniciada!'
    # Adicione sua lógica aqui

    chain_db = ChainDb::Features::ChainDb.new
    chain_db.connect('https://gull-dominant-mistakenly.ngrok-free.app', 'chat-app-db', 'root', 'chat-db-#z7e185yH4')
    # puts chain_db.auth

    # get weather messages table
    # messages_table = chain_db.get_table('messages-weather')

    puts '== create message =='
    new_message = Models::Message.new(username: 'Mr. Nobody', message: 'Hello, world!', b64Image: 'https://picsum.photos/200/200')
    puts new_message.persist.to_h
    puts '== create message end =='

    # puts '== get all messages =='
    # Models::Message.all(50).each do |message|
    #   puts message.to_h
    # end
    # puts '== get all messages end =='

    # puts '== fix all messages without content =='
    # Models::Message.all(50).each do |message|
    #   # puts message.to_h if message.username.empty?
    #   next unless message.username.empty?

    #   message.username = 'Fix'
    #   message.message = 'This message is fixed :D'
    #   message.persist
    # end
    # puts '== fix all messages without content end =='

    # puts '== get many messages by username =='
    # Models::Message.all_where(criteria: { username: 'Mr. Nobody' }).each do |message|
    #   puts message.to_h
    # end
    # puts '== get many messages by username end =='

    # puts '== get many messages by username and message contains 3333 =='
    # criteria = [
    #   ChainDb::Features::Utils.build_criteria(field: 'username', operator: ChainDb::Features::Operators::EQUAL,
    #                                           value: 'Mr. Nobody'),
    #   ChainDb::Features::Utils.build_criteria(field: 'message', operator: ChainDb::Features::Operators::CONTAINS,
    #                                           value: '3333')
    # ]
    # puts Models::Message.where_advanced(criteria: criteria).to_h
    # puts '== get many messages by username and message contains 3333 end =='

    # puts '== get many messages by username and message contains 3333 =='
    # criteria = [
    #   # ChainDb::Features::Utils.build_criteria(field: 'username', operator: ChainDb::Features::Operators::EQUAL,
    #   #                                         value: 'Mr. Nobody'),
    #   # ChainDb::Features::Utils.build_criteria(field: 'message', operator: ChainDb::Features::Operators::CONTAINS,
    #   #                                         value: '3333')
    #   ChainDb::Features::Utils.build_criteria(field: 'b64Image', operator: ChainDb::Features::Operators::CONTAINS,
    #                                           value: 'https://picsum.photos')
    # ]
    # Models::Message.all_where_advanced(criteria: criteria).each do |message|
    #   puts message.to_h
    # end
    # puts '== get many messages by username and message contains 3333 end =='

    # puts '== get message by username =='
    # message_data = Models::Message.where(criteria: { username: 'Mr. Nobody' })
    # puts message_data.message
    # puts message_data.to_h
    # puts '== get message by username end =='

    # puts '== get message by username and update its data =='
    # message_data = Models::Message.where(criteria: { doc_id: 'b30ba45f-175b-4c2e-bc18-4bf6c288b295' })
    # puts "original data: #{message_data.to_h}"
    # message_data.message = 'Hello, world! Updated 3333'
    # puts "updated data: #{message_data.persist}"
    # puts '== get message by username and update its data end =='

    # puts '== get last message =='
    # last_message = Models::Message.last
    # puts "Last data: #{last_message.to_h}"
    # puts '== get last message end =='

    # puts '== get message by doc_id =='
    # message_data = Models::Message.by_doc_id('b30ba45f-175b-4c2e-bc18-4bf6c288b295')
    # puts "Message data: #{message_data.to_h}"
    # puts '== get message by doc_id end =='

    # loop to persist a new weather message every 5 seconds
    # puts '== creating new random messages =='
    # puts "\n"
    # loop do
    #   begin
    #     # fetch random text
    #     random_text = HTTParty.get('https://api.chucknorris.io/jokes/random').parsed_response

    #     username = ['Mr. Nobody', 'Chuck Norris', 'Yuppie Noob', 'Leopoldino', 'Tulipete'][rand(0..4)]
    #     picture = [random_text['icon_url'], "https://picsum.photos/#{rand(150..400)}/#{rand(150..400)}"][rand(0..1)]

    #     new_message = Models::Message.new(username: username, message: random_text['value'],
    #                                       b64Image: picture).persist

    #     puts "Success ===> #{new_message.to_h}"
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
