module Impale
  module JsonApi
    class Serializer
      attr_reader :input, :attributes

      def initialize(input)
        @input = input
        @attributes = self.class.attributes
        @traversor = Impale::JsonApi::HashObjectTraversor.new
      end

      def _serialize

      end

      def serialize
        data = []
        if @input.is_a?(Array)
          data += @input.map do |input|
            change_path(input)
            build_node
          end
        else
          change_path(@input)
          data << build_node
        end

        {
            data: data
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

      def change_path(path)
        @traversor.input = path
      end

      def build_node
        {
          attributes: @traversor.traverse_non_nested(@attributes)
        }
      end

      private :change_path, :build_node
    end
  end
end