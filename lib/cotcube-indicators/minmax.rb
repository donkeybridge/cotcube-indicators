# frozen_string_literal: true

module Cotcube
  module Indicators

    # returns the maximum - minimum within carrier
    def minmax(key:, length:)
      carrier = Carrier.new(length: length)
      return lambda do |x|
        current = x[key.to_sym]
        carrier << current
        return (carrier.get.max - carrier.get.min).to_f
      end
    end

  end
end

