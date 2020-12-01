module Cotcube
  module Indicators

    # returns the difference between the current value and the first available value in carrier. 
    #    if block given, the block is evaluated as conditional, using current and carrier.get.last.
    #    if evaluation is false, carrier remains untouched and 0 is returned
    def change(key:, lookback: 1, debug: false)
      puts "invalid lookback period, need integer >= 1" unless lookback.is_a?(Integer) and lookback >= 1
      carrier = Cotcube::Indicators::Carrier.new(length: lookback + 1)

      return lambda do |x|
        current = x[key.to_sym]
        current = 0 unless current.is_a?(Numeric)
        carrier << 0 if carrier.empty?
        puts "comparing #{current} from #{key.to_sym} ... #{lookback} ... #{carrier.inspect} ... yield #{yield(carrier.get.last, current) if block_given?}" if debug
        if not block_given? or yield(carrier.get.last, current)
          carrier << current
          ret = carrier.size < lookback + 1 ? 0 : (carrier.get.last - carrier.get.first)
          return ret.to_f
        else
          return 0
        end
      end
    end
  end
end
