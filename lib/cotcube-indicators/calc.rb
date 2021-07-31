# frozen_string_literal: true

module Cotcube
  module Indicators
    def calc(a:, b:, c:nil, d:nil, e:nil, &block)   # rubocop:disable Naming/MethodParameterName
      lambda do |x|
        block.call(x[a.to_sym], x[b.to_sym], x[c.to_sym], x[d.to_sym], x[e.to_sym]).to_f
      end
    end
  end
end
