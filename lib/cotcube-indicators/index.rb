# frozen_string_literal: true

module Cotcube
  module Indicators

    def index(debug: false, key:, length:, reverse: false, abs: false)
      carrier = Carrier.new(length: length)

      return lambda do |x|
        current = x[key.to_sym]
        puts "comparing #{current} from #{key} ... #{length.nil? ? 0 : length} with yield #{yield(current) if block_given?}" if debug
        if not block_given? or yield(current)
          current = current.abs if abs
          puts "CURRENT: #{current}" if debug
          carrier << current
          puts "CARRIER: #{carrier.inspect}" if debug
          divisor = carrier.get.max - carrier.get.min
          puts "#{divisor} = #{carrier.get.max} - #{carrier.get.min}" if debug
          res =  divisor.zero? ? -1.0: ((current - carrier.get.min) / divisor.to_f)
          puts "RESULT: #{res}" if debug
          return reverse ? ( 1 - res.round(3).to_f ) : res.round(3).to_f
        else
          carrier.shift
          return 0
        end
      end
    end
  end
end


