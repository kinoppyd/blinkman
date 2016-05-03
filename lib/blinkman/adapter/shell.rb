module Blinkman
  module Adapter
    class Shell < Base
      require 'readline'

      attr_reader :stopped

      PROMPT = '> '

      def initialize(bot)
        @stopped = false
        super
      end

      def listen
        while ! stopped
          bot.on_receive(read)
        end
      end

      def read
        Message::Shell.new(
          Readline.readline(PROMPT, true).tap do |line|
            @stopped = (line == 'exit')
          end
        )
      end
    end
  end
end
