# frozen_string_literal: true

require_relative '../lib/cotcube-indicators'

RSpec.describe Cotcube::Indicators do
  context 'change' do
    it 'should raise argument error when called without :key argument' do 
      expect{Cotcube::Indicators.change}.to raise_error(ArgumentError)
      expect{Cotcube::Indicators.change(key: :foo, lookback: :bar)}.to raise_error(ArgumentError)
      expect{Cotcube::Indicators.change(key: :foo, lookback: 2.5)}.to raise_error(ArgumentError)
      expect{Cotcube::Indicators.change(key: :foo, lookback: 5)}.not_to raise_error
    end 
    it 'should calculate appropriately' do 
      indicators = { 
        :first => Cotcube::Indicators.change(key: :a),
        :second => Cotcube::Indicators.change(key: :b, lookback: 3) 
      }
      data = 10.times.map{|i| {a: i, b: (10+i) * ((-1)**i)} } 

      data.each do |d| 
        indicators.each do |key, lambada| 
          d[key.to_sym] = lambada.call(d)
        end
      end
      # testing by example
      expect(data.map{|x| x[:first]}).to eq([0.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0])
      expect(data.map{|x| x[:second]}).to eq([0.0, 0.0, 12.0, -23.0, 25.0, -27.0, 29.0, -31.0, 33.0, -35.0])
    end
  end
end

