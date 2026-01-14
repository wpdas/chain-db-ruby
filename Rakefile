# frozen_string_literal: true

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc 'Executa o linter RuboCop'
task :lint do
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new
end

desc 'Executa todos os testes'
task test: :spec


