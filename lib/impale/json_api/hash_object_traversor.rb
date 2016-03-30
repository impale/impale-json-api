module Impale
  module JsonApi
    class HashObjectTraversor
      def initialize(obj)
        @obj = obj
      end

      # @param [Array] list
      # @return [Hash]
      def traverse_non_nested(list)
        hash = {}
        list.each do |key|
          if key.is_a? Hash
            key.each do |k, v|
              hash[k] = @obj.send(v)
            end
          else
            hash[key] = @obj.send(key)
          end
        end
        hash
      end
    end
  end
end