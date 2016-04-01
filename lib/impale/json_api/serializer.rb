module Impale
  module JsonApi
    class Serializer
      attr_accessor :input
      attr_reader :attributes, :type, :id

      def initialize(input, serialize_type =nil)
        @serialize_type = serialize_type  || :root
        @input = input
        @attributes = self.class.attributes
        @type = self.class.type
        @id = self.class.id
        @belongs_to_relationships = self.class.belongs_to_relationships
        @traversor = Impale::JsonApi::HashObjectTraversor.new
      end

      def serialize
        output = []
        if @input.is_a?(Array)
          output += @input.map do |input|
            build_node(input)
          end
        else
          output << build_node(@input)
        end

        {data: output}
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
          belongs_to_relationships.push({relationship: relationship, serializer: args[:serializer]})
        end

        def belongs_to_relationships
          @belongs_to_relationships ||= []
        end
      end

      # @return [Hash]
      # @param [Object] current_object
      def build_node(current_object)
        @traversor.input = current_object
        base_hash = {
            type: @type,
            id:  current_object.send(@id)
        }

        case @serialize_type
          when :root
            base_hash.merge!({
               attributes: @traversor.traverse_non_nested(@attributes),
               relationships: traverse_relationships(current_object)
            })
          when :relationship
            base_hash
          else
            base_hash
        end
      end

      def traverse_relationships(current_object)
        relationships = {}
        @belongs_to_relationships.each do |belongs_to|
          relationships[belongs_to[:relationship]] = belongs_to[:serializer].new(current_object.send(belongs_to[:relationship]), :relationship)
                                .serialize
        end
        relationships
      end

      private :build_node, :traverse_relationships
    end
  end
end