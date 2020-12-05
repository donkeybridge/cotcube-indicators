# frozen_string_literal: true

module Cotcube
  module Indicators
    # the classic exponential moving average
    def ema(key:, length:, smoothing: nil)
      raise 'Missing parameter, need :length' unless length.is_a? Integer

      smoothing ||= (2 / (length - 1).to_f.round(2))
      carrier = Carrier.new(length)
      lambda do |x|
        current = x[key.to_sym]
        carrier << if carrier.empty?
                     current * (smoothing / (1 + length))
                   else
                     current * (smoothing / (1 + length)) + carrier.get[-1] * (1 - (smoothing / (1 + length)))
                   end
        carrier.size < length ? -1.0 : carrier.get.last
      end
    end
  end
end
