# frozen_string_literal: true

module Cotcube
  module Indicators

    def score(key:, length:, debug: false, abs: false, index: false)
      # returns the position of current within carrier after sorting, i.e. if current has the highest rank it becomes 1, the lowest becomes :length
      # to create comparable results for changing lengths, the score is put onto an index with toprank of 1 (1 - 0/:length)
      carrier = Carrier.new(length: length)
      return lambda do |x|
	current = x[key.to_sym]
	current = current.abs if abs
	if current.zero?
          carrier.shift
          return 0

	end
	carrier << current
	score = carrier.get.sort.reverse.find_index(current)
	sindx = (1 - score/length.to_f).round(3)
	index ? sindx : (score + 1)
      end
    end
  end
end

