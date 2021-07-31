# frozen_string_literal: true

module Cotcube
  module Indicators
    # threshold returns 
    def threshold(key:, upper: nil, lower: nil, repeat: false, abs: false, debug: false)
      raise ArgumentError, "Need to set :upper: (set to Float::INFINITY to omit)" if upper.nil? 
      raise ArgumentError, "Need to set :lower unless :abs is set" if lower.nil? and not abs
      raise ArgumentError, ":lower, upper must be numeric" if not upper.is_a?(Numeric) and ( abs ? true : lower.is_a?(Numeric) )
      raise ArgumentError, "Found bogus, :lower #{lower} must be lower than :upper #{upper}" if not abs and lower > upper
      # For this indicator, we just need to remembers -1, 0 or 1. That does not need a helper class.
      carrier = 0

      lambda do |current|
        current = current[key.to_sym]
        current = current.abs if abs
        puts "UPPER: #{upper}\tLOWER: #{lower}\tCARRIER was: #{carrier}\tCURRENT: #{current}" if debug
        # facing options
        # 1. carrier is zero
        if carrier.zero? 
          # 1.a. and threshold
          if current >= upper 
            carrier = 1
            return 1
          elsif not abs and current <= lower  
            carrier = -1
            return -1
          # 1.b. and no threshold
          else
            return 0
          end
        # 2. carrier is non-zero
        else
          # and threshold
          #   if threshold matches carrier, return 0 and keep carrier or return carrier if :repeat
          #   if not abs, allow reversing on appropriate threshold
          if carrier.positive? and current >= upper 
            return repeat ?  1 : 0 
          elsif not abs and carrier.negative? and current <= lower
            return repeat ? -1 : 0
          elsif not abs and carrier.positive? and current <= lower
            carrier = -1
            return -1
          elsif not abs and carrier.negative? and current >= upper
            carrier = 1
            return 1
          # and no threshold
          #   silently unset carrier, return 0
          else
            carrier = 0
            return 0 
          end
        end
      end
    end
  end
end
