module Blinkman
  module Adapter
    class Base
      attr_reader :bot
      class << self
        def inherited(klass)
          Adapter.adapter_classes.push(klass)
        end
      end

      def initialize(bot)
        @bot = bot
      end

      def listen
        raise NotImplementedError.new
      end
    end
  end
end
