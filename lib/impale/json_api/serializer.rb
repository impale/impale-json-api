module Impale
  module JsonApi
    class Serializer
      attr_reader :input, :attributes

      def initialize(input)
        @input = input
        @attributes = self.class.attributes
      end

      def serialize
        @traversor = Impale::JsonApi::HashObjectTraversor.new(@input)
        {
          data: [
            attributes: @traversor.traverse_non_nested(@attributes)
          ]
        }
      end

      class << self
        def attributes(*_attributes)
          unless _attributes.empty?
            @attributes = _attributes
          end
          @attributes
        end
      end
    end
  end
end