# frozen_string_literal: true

require_relative '../lib/cotcube-indicators'

RSpec.describe Cotcube::Indicators::Carrier do
  it 'should not initialize without length' do
    expect{Cotcube::Indicators::Carrier.new}.to raise_error(ArgumentError)
  end
  it 'should not initialize with bogus length' do 
    expect{Cotcube::Indicators::Carrier.new(length: 1.2)}.to raise_error(ArgumentError)
  end

  it 'should initialize with ok length' do
    expect{Cotcube::Indicators::Carrier.new(length: 5)}.not_to raise_error
  end

  it 's content should not grow beyond length' do
    length = 5
    carrier = Cotcube::Indicators::Carrier.new(length: length)
    20.times do 
      carrier << Random.rand
      expect(carrier.get.size).to be <= length
      expect(carrier.size).to be <= length
    end
  end
end

