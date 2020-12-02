# frozen_string_literal: true

require_relative '../lib/cotcube-indicators'

RSpec.describe Cotcube::Indicators do
  context 'true_range' do
    it 'calculates accordingly' do
      indicators = { tr: Cotcube::Indicators.true_range(high: :h, low: :l, close: :c) }
      data       = [ { h: 10, l: 5, c: 6 },
                     { h: 10, l: 3, c: 5 },
                     { h: 10, l: 7, c: 8 },
                     { h: 12, l: 10, c: 10} ]

      data.each {|d| 
        indicators.each {|key, lambada| d[key.to_sym] = lambada.call(d) }
      }
      expect(data.map{|x| x[:tr]}).to eq([5.0, 7.0, 5.0, 4.0])
    end
  end
end

