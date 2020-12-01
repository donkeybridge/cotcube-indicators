# frozen_string_literal: true

module Cotcube
  module Indicators
    def rsi(length:, key:, debug: false)
      raise "Missing parameter, need :key and :length options" if length.nil? or key.nil?
      carrier = Carrier.new(length: length)

      return lambda do |x|
        current = x[key.to_sym]
        carrier << current
        puts ". #{carrier.get} ." if debug
        return 50.0 if carrier.length < length
        u = carrier.get.select{|x| x > 0}.map{|x| x.abs}.reduce(:+)
        d = carrier.get.select{|x| x < 0}.map{|x| x.abs}.reduce(:+)
        d = d.nil? ? 10 ** -12 : d / length.to_f
        u = u.nil? ? 10 ** -12 : u / length.to_f
        return (100 - (100 / ( 1 + u / d) )).to_f
      end
    end
  end
end
