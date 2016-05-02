module Blinkman
  class Handler
    attr_reader :action, :event
    def initialize(action, event)
      @action = action
      @event = event
    end
  end
end
