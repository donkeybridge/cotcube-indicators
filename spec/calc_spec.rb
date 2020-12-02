# frozen_string_literal: true

require_relative '../lib/cotcube-indicators'

RSpec.describe Cotcube::Indicators do
  context 'calc' do
    it 'should calculate appropriately' do 
      indicators = { 
        :inc => Cotcube::Indicators.calc(a: :a, b: :b) {|x,y| x + 1 },
        :add => Cotcube::Indicators.calc(a: :a, b: :b) {|x,y| x + y},
        :sub => Cotcube::Indicators.calc(a: :a, b: :b) {|x,y| x - y}
      }
      data = 10.times.map{|i| {a: i, b: 10+i} } 

      data.each do |d| 
        indicators.each do |key, lambada| 
          d[key.to_sym] = lambada.call(d)
        end
        expect(d[:inc]).to eq(d[:a] + 1)
        expect(d[:add]).to eq(d[:a] + d[:b])
        expect(d[:sub]).to eq(d[:a] - d[:b])
      end
    end
  end
end

