# frozen_string_literal: true

require_relative '../lib/cotcube-indicators'

RSpec.describe Cotcube::Indicators do
  context 'ema' do
    it 'should raise argument error when called without :key argument' do 
      expect{Cotcube::Indicators.ema}.to raise_error(ArgumentError)
    end
    it 'should raise argument error when called with improper arguments' do 
      expect{Cotcube::Indicators.ema(key: :foo)}.to raise_error(ArgumentError)
      expect{Cotcube::Indicators.ema(key: :foo, length: 21, smoothing: :foo)}.to raise_error(ArgumentError)
      expect{Cotcube::Indicators.ema(key: :foo, length: 21, smoothing: 12)}.not_to raise_error
      expect{Cotcube::Indicators.ema(key: :foo, length: 5)}.not_to raise_error
    end 
    it 'should calculate appropriately' do 
      indicators = { 
        :first => Cotcube::Indicators.ema(key: :b, length: 6), 
      }
      data = 13.times.map{|i| {a: i, b: ((10+i) * (((-i+2)/(i+1.0))**i)).round(3)} } 
      5.times { data << { a: 12, b: 10 } } 

      data.each do |d| 
        indicators.each do |key, lambada| 
          d[key.to_sym] = lambada.call(d).round(3)
        end
      end
      # expectations by tested example--they are not here to prove proper work but simple fluency
      #   on application of all switches
      expect(data.map{|x| x[    :b]}).to eq([10.0,  5.5,  0.0, -0.203, 0.358, -0.469, 0.557, -0.633, 0.702, -0.767, 0.828, -0.887, 0.944,    10,    10,    10,    10,    10])
      expect(data.map{|x| x[:first]}).to eq([-1.0, -1.0, -1.0,   -1.0,  -1.0,  0.656, 0.651,  0.577, 0.584,  0.507, 0.526,  0.445, 0.473, 1.018, 1.531, 2.015, 2.471, 2.901])
    end
  end
end

