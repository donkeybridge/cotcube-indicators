# frozen_string_literal: true

require_relative '../lib/cotcube-indicators'

RSpec.describe Cotcube::Indicators do
  context 'change' do
    it 'should raise argument error when called without :key argument' do 
      expect{Cotcube::Indicators.score}.to raise_error(ArgumentError)
    end
    it 'should raise argument error when called with improper lookback value' do 
      expect{Cotcube::Indicators.score(key: :foo, length: :bar)}.to raise_error(ArgumentError)
      expect{Cotcube::Indicators.score(key: :foo, length: 2.5)}.to raise_error(ArgumentError)
      expect{Cotcube::Indicators.score(key: :foo, length: 5)}.not_to raise_error
    end 
    it 'should calculate appropriately' do 
      indicators = { 
        :first  => Cotcube::Indicators.score(key: :a, length: 5),
        :second => Cotcube::Indicators.score(key: :b, length: 10), 
        :third  => Cotcube::Indicators.score(key: :b, length: 10, abs: true),
        :fourth => Cotcube::Indicators.score(key: :b, length: 10, index: true),
        :fifth  => Cotcube::Indicators.score(key: :b, length: 10, abs: true, index: true)
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
      expect(data.map{|x| x[ :first]}).to eq([   0,   1,   1,      1,     1,      1,     1,      1,     1,      1,     1,      1,     1])
      expect(data.map{|x| x[:second]}).to eq([   1,   2,   0,      2,     2,      4,     2,      6,     2,      8,     2,     10,     1])
      expect(data.map{|x| x[ :third]}).to eq([   1,   2,   0,      2,     2,      2,     2,      2,     2,      2,     2,      2,     1])
      expect(data.map{|x| x[:fourth]}).to eq([ 1.0, 0.9,   0,    0.9,   0.9,    0.7,   0.9,    0.5,   0.9,    0.3,   0.9,    0.1,   1.0])
      expect(data.map{|x| x[ :fifth]}).to eq([ 1.0, 0.9,   0,    0.9,   0.9,    0.9,   0.9,    0.9,   0.9,    0.9,   0.9,    0.9,   1.0])



    end
  end
end

