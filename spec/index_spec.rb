# frozen_string_literal: true

require_relative '../lib/cotcube-indicators'

RSpec.describe Cotcube::Indicators do
  context 'change' do
    it 'should raise argument error when called without :key argument' do 
      expect{Cotcube::Indicators.index}.to raise_error(ArgumentError)
    end
    it 'should raise argument error when called with improper lookback value' do 
      expect{Cotcube::Indicators.index(key: :foo, length: :bar)}.to raise_error(ArgumentError)
      expect{Cotcube::Indicators.index(key: :foo, length: 2.5)}.to raise_error(ArgumentError)
      expect{Cotcube::Indicators.index(key: :foo, length: 5)}.not_to raise_error
    end 
    it 'should calculate appropriately' do 
      indicators = { 
        :first  => Cotcube::Indicators.index(key: :a, length: 5),
        :second => Cotcube::Indicators.index(key: :b, length: 10), 
        :third  => Cotcube::Indicators.index(key: :b, length: 10, abs: true),
        :fourth => Cotcube::Indicators.index(key: :b, length: 10, reverse: true),
        :fifth  => Cotcube::Indicators.index(key: :b, length: 10, abs: true, reverse: true)
      }
      data = 13.times.map{|i| {a: i, b: ((10+i) * (((-i+2)/(i+1.0))**i)).round(3)} } 

      data.each do |d| 
        indicators.each do |key, lambada| 
          d[key.to_sym] = lambada.call(d)
        end
      end
      # expectations by tested example--they are not here to prove proper work but simple fluency
      #   on application of all switches
      expect(data.map{|x| x[     :b]}).to eq([10.0, 5.5, 0.0, -0.203, 0.358, -0.469, 0.557, -0.633, 0.702, -0.767, 0.828, -0.887, 0.944])
      expect(data.map{|x| x[ :first]}).to eq([-1.0, 1.0, 1.0,    1.0,   1.0,    1.0,   1.0,    1.0,   1.0,    1.0,   1.0,    1.0,   1.0])
      expect(data.map{|x| x[:second]}).to eq([-1.0, 0.0, 0.0,    0.0, 0.055,    0.0, 0.098,    0.0, 0.126,    0.0, 0.255,    0.0,   1.0])
      expect(data.map{|x| x[ :third]}).to eq([-1.0, 0.0, 0.0,   0.02, 0.036,  0.047, 0.056,  0.063,  0.07,  0.077, 0.151,    1.0,   1.0])
      expect(data.map{|x| x[:fourth]}).to eq([-1.0, 1.0, 1.0,    1.0, 0.945,    1.0, 0.902,    1.0, 0.874,    1.0, 0.745,    1.0,   0.0])
      expect(data.map{|x| x[ :fifth]}).to eq([-1.0, 1.0, 1.0,   0.98, 0.964,  0.953, 0.944,  0.937,  0.93,  0.923, 0.849,    0.0,   0.0])


    end
  end
end

