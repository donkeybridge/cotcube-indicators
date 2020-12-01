# frozen_string_literal: true

module Cotcube
  module Indicators
    class Carrier

      def initialize(length:)
	raise "Need a length for the carrier" unless length and length.is_a? Integer
	@length = length
	@content = []
      end

      def <<(obj)
	@content << obj
	@content.shift if @content.length > @length
	obj
      end

      def shift
	@content.shift
        # sending explicit return to avoid returning a value here
	return
      end

      def clear
	@content = []
      end

      def get
	@content
      end

      def size
	@content.size
      end
      alias_method :length, :size

      def empty?
	@content.empty?
      end

      def [](key)
	@content.map{|x| x[key]}
      end
    end
  end

end
