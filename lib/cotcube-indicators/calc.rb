# frozen_string_literal: true

module Cotcube
  module Indicators
    def calc(a:, b:, c:nil, d:nil, e:nil, f:nil, g:nil, h:nil, finalize: :to_f, &block)   # rubocop:disable Naming/MethodParameterName
      lambda do |x|
        block.call(
          x[a.to_sym],
          (b.nil? ? nil : x[b.to_sym]),
          (c.nil? ? nil : x[c.to_sym]),
          (d.nil? ? nil : x[d.to_sym]),
          (e.nil? ? nil : x[e.to_sym]),
          (f.nil? ? nil : x[f.to_sym]),
          (g.nil? ? nil : x[g.to_sym]),
        ).send(finalize.to_sym)
      end
    end
  end
end
