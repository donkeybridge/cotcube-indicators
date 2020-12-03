# frozen_string_literal: true

require_relative '../lib/cotcube-indicators'

RSpec.describe Cotcube::Indicators do
  context 'change' do
    it 'should raise argument error when called without :key argument' do 
      expect{Cotcube::Indicators.threshold}.to raise_error(ArgumentError)
    end
    context 'should raise argument error when called with improper :upper, :lower values' do 
      it 'both thresholds missing' do
        expect{Cotcube::Indicators.threshold(key: :foo                       )}.to raise_error(ArgumentError)
      end
      it 'upper is bogus, lower is missing' do
        expect{Cotcube::Indicators.threshold(key: :foo, upper: :bar          )}.to raise_error(ArgumentError)
      end
      it 'upper is lte lower' do 
        expect{Cotcube::Indicators.threshold(key: :foo, upper: 5, lower: 5   )}.to raise_error(ArgumentError)
        expect{Cotcube::Indicators.threshold(key: :foo, upper: 4, lower: 5   )}.to raise_error(ArgumentError)
      end
      it 'lower is unset' do 
        expect{Cotcube::Indicators.threshold(key: :foo, upper: 5             )}.to raise_error(ArgumentError)
      end
      it 'lower is bogus' do
        expect{Cotcube::Indicators.threshold(key: :foo, upper: 4, lower: :bar)}.to raise_error(ArgumentError)
      end
      it 'nonfailing with both upper and lower' do
        expect{Cotcube::Indicators.threshold(key: :foo, upper: 6.25, lower: 5)}.not_to raise_error
      end
      it 'nonfailing with upper and abs' do 
        expect{Cotcube::Indicators.threshold(key: :foo, upper: 6.2, abs: true)}.not_to raise_error
      end
    end 
    it 'should calculate appropriately' do 
      indicators = { 
        :first  => Cotcube::Indicators.threshold(key: :b, upper: 0.5, abs: true),
        :second => Cotcube::Indicators.threshold(key: :b, upper: 0.5, lower: -Float::INFINITY),
        :third  => Cotcube::Indicators.threshold(key: :b, upper: 0.5, lower: -0.5),
        :fourth => Cotcube::Indicators.threshold(key: :b, upper: 0.5, abs: true, repeat: true),
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
      expect(data.map{|x| x[ :first]}).to eq([   1,   0,   0,      0,     0,      0,     1,      0,     0,      0,     0,      0,     0])
      expect(data.map{|x| x[:second]}).to eq([   1,   0,   0,      0,     0,      0,     1,      0,     1,      0,     1,      0,     1])
      expect(data.map{|x| x[ :third]}).to eq([   1,   0,   0,      0,     0,      0,     1,     -1,     1,     -1,     1,     -1,     1])
      expect(data.map{|x| x[:fourth]}).to eq([   1,   1,   0,      0,     0,      0,     1,      1,     1,      1,     1,      1,     1])

    end
  end
end

