# frozen_string_literal: true

require 'rubygems/package'
require_relative 'cotcube-indicators/__carrier'
require_relative 'cotcube-indicators/calc'
require_relative 'cotcube-indicators/change'
require_relative 'cotcube-indicators/index'
require_relative 'cotcube-indicators/score'
require_relative 'cotcube-indicators/ema'
require_relative 'cotcube-indicators/sma'
require_relative 'cotcube-indicators/rsi'
require_relative 'cotcube-indicators/true_range'

module Cotcube
  module Indicators
    module_function :calc, :change, :ema, :sma, :rsi, :true_range, :index, :score
  end
end
