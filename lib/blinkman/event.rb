module Blinkman
  class Event
    def initialize(&block)
      @block = block
    end

    def match?(message)
      @block.call(message) if @block
    end
  end
end
