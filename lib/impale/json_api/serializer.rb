module Impale
  module JsonApi
    class Serializer
      attr_reader :attributes, :obj

      def initialize(obj)
        @obj = obj
      end
    end
  end
end