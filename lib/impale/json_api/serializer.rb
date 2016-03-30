module Impale
  module JsonApi
    class Serializer
      attr_accessor :input
      attr_reader :attributes, :type, :id

      def initialize(input)
        @input = input
        @attributes = self.class.attributes
        @type = self.class.type
        @id = self.class.id
        @traversor = Impale::JsonApi::HashObjectTraversor.new
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
        # @param [Array] _attributes
        # @return [Array]
        def attributes(*_attributes)
          unless _attributes.empty?
            @attributes = _attributes
          end
          @attributes
        end

        def type(type=nil)
          if type
            @type = type
          end
          @type
        end

        def id(id=nil)
          if id
            @id = id
          end
          @id
        end
      end

      # @param [Object] path
      def change_path(path)
        @traversor.input = path
      end

      # @return [Hash]
      def build_node
        {
          attributes: @traversor.traverse_non_nested(@attributes)
        }
      end

      private :change_path, :build_node
    end
  end
end