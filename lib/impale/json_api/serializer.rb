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
            build_node(input)
          end
        else
          data << build_node(@input)
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

        def type(type = nil)
          if type
            @type = type
          end
          @type
        end

        def id(id = nil)
          if id
            @id = id
          end
          @id
        end

        def has_many(relationship, args)

        end

        def belongs_to(relationship, args)

        end
      end

      # @return [Hash]
      # @param [Object] current_object
      def build_node(current_object)
        @traversor.input = current_object
        {
          type: @type,
          id:  current_object.send(@id),
          attributes: @traversor.traverse_non_nested(@attributes)
        }
      end

      private :build_node
    end
  end
end