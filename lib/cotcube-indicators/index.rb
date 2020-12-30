# frozen_string_literal: true

module Cotcube
  module Indicators
    def index(key:, length:, debug: false, reverse: false, abs: false)
      carrier = Carrier.new(length: length)

      lambda do |x|
        current = x[key.to_sym]
        if debug
          puts "comparing #{current} from #{key} ... "\
               "#{length.nil? ? 0 : length} with yield #{block_given? ? yield(current) : ''}"
        end
        if (not block_given?) || yield(current)
          current = current.abs if abs
          puts "CURRENT: #{current}" if debug
          carrier << current
          puts "CARRIER: #{carrier.inspect}" if debug
          divisor = carrier.get.max - carrier.get.min
          puts "#{divisor} = #{carrier.get.max} - #{carrier.get.min}" if debug
          return -1.0 if divisor.zero?

          res = ((current - carrier.get.min) / divisor.to_f)
          puts "RESULT: #{res}" if debug
          return reverse ? (1 - res.to_f).round(3).to_f : res.round(3).to_f
        else
          carrier << 0
          return 0
        end
      end
    end
  end
end
