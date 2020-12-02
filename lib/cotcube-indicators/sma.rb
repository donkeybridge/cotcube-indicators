# frozen_string_literal: true

module Cotcube
  module Indicators
    def sma(length:, key:)
      raise 'Missing parameter, need :length and :value options' if opts[:length].nil? || opts[:value].nil?

      carrier = Cotcube::Indicators::Carrier.new(length: length)
      lambda do |x|
        current = x[key.to_sym]
        carrier << current
        carrier.size < length ? 0.0 : (carrier.get.reduce(:+) / carrier.length).to_f
      end
    end
  end
end
