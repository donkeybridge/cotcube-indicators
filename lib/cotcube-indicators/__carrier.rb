# frozen_string_literal: true

module Cotcube
  module Indicators
    class Carrier
      def initialize(length:)
        raise ArgumentError, 'Need a length to be an integer' unless length.is_a? Integer

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
        nil
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
      alias length size

      def empty?
        @content.empty?
      end

      def [](key)
        @content.map { |x| x[key] }
      end
    end
  end
end
