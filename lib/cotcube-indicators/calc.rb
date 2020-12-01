# frozen_string_literal: true

module Cotcube
  module Indicators

    def calc(a:, b:, &block)
      return lambda do |x|
	block.call(x[a.to_sym], x[b.to_sym]).to_f
      end
    end
  end
end

