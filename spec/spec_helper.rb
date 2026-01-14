# frozen_string_literal: true

require 'bundler/setup'
require_relative '../lib/application'

RSpec.configure do |config|
  # Habilita flags como --only-failures e --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Desabilita o monkey-patching do RSpec no módulo global
  config.disable_monkey_patching!

  # Configura para usar expect ao invés de should
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end


