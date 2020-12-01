# frozen_string_literal: true

module Cotcube
  module Indicators

    def true_range
      carrier = Carrier.new(length: 1)
      return lambda do |x|
        if carrier.get.empty?
          carrier << x
          return (x[:high] - x[:low]).to_f
        end
        last = carrier.get[0]
        current = x
        carrier << current
        ([ current[:high], last[:close] ].max - [ current[:low], last[:close] ].min).to_f
      end
    end
  end
end

