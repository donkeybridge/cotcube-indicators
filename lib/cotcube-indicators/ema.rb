# frozen_string_literal: true

module Cotcube
  module Indicators

    # the classic exponential moving average
    def ema(key:, length:, smoothing: )
      raise "Missing parameter, need :length" if length.nil? or not length.is_a? Integer
      raise "Missing parameter, need :key"    if key.nil?

      smoothing  ||= (2 / (length - 1).to_f.round(2))
      carrier = Carrier.new(length)
      return lambda do |x|
        current = x[key.to_sym]
        if carrier.empty?
          carrier << current * ( smoothing / ( 1 + length) )
        else
          carrier << current * ( smoothing / ( 1 + length) ) + carrier.get[-1] * ( 1 - ( smoothing / ( 1 + length ) ) )
        end
        carrier.size < length ? -1.0 : carrier.get.last
      end
    end

  end
end
