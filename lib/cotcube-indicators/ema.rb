# frozen_string_literal: true

module Cotcube
  module Indicators
    # the classic exponential moving average
    def ema(key:, length:, smoothing: nil)
      raise ArgumentError, 'Improper :length parameter, should be positive Integer' unless length.is_a? Integer and length.positive?

      smoothing ||= (2 / (length - 1).to_f.round(2))
      raise ArgumentError, 'Improper smoothing, should be Numeric' unless smoothing.is_a? Numeric

      carrier = Cotcube::Indicators::Carrier.new(length: length)
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
