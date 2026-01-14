# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Application do
  describe '#initialize' do
    it 'cria uma nova instância da aplicação' do
      app = Application.new
      expect(app).to be_a(Application)
    end
  end

  describe '#stop' do
    it 'para a aplicação' do
      app = Application.new
      app.stop
      expect(app.instance_variable_get(:@running)).to be false
    end
  end
end


