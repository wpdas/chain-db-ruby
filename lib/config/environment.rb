# frozen_string_literal: true

require 'bundler/setup'
require 'dotenv/load'

# Configuração do ambiente
module Config
  module Environment
    def self.load
      # Carrega variáveis de ambiente do arquivo .env
      Dotenv.load if File.exist?('.env')
    end
  end
end

Config::Environment.load


