# frozen_string_literal: true

module Cotcube
  module Indicators
    def true_range(high: :high, low: :low, close: :close)
      carrier = Carrier.new(length: 1)
      lambda do |current|
        raise "Missing keys of #{high}, #{low}, #{close} in '#{current}'" unless [high, low, close] - current.keys == []

        if carrier.empty?
          carrier << current
          return (current[high] - current[low]).to_f
        end
        last = carrier.get.first
        carrier << current
        ([current[high], last[close]].max - [current[low], last[close]].min).to_f
      end
    end
  end
end
