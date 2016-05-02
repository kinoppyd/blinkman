module Blinkman
  module Message
    class Base
      attr_reader :original_message
      def initialize(original_message)
        @original_message = original_message
      end

      def body
        raise NotImplementedError.new
      end
    end
  end
end
