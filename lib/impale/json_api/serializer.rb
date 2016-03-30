module Impale
  module JsonApi
    class Serializer
      attr_reader :obj, :attributes

      def initialize(obj)
        @obj = obj
        @attributes = self.class.attributes
        @traversor = Impale::JsonApi::HashObjectTraversor.new(@obj)
      end

      def serialize
        @traversor.traverse_non_nested(@attributes)
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