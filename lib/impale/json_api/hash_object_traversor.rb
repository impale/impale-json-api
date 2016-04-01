module Impale
  module JsonApi
    class HashObjectTraversor
      attr_accessor :input

      # @param [Array] list
      # @return [Hash]
      def traverse_non_nested(list)
        hash = {}
        unless list
          return hash
        end
        list.each do |key|
          if key.is_a? Hash
            key.each do |k, v|
              hash[k] = @input.send(v)
            end
          else
            hash[key] = @input.send(key)
          end
        end
        hash
      end
    end
  end
end