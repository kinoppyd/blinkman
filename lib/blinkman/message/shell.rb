module Blinkman
  module Message
    class Shell < Base
      def body
        original_message
      end
    end
  end
end
