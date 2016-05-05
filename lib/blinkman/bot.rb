require 'dotenv'

module Blinkman
  class Bot

    attr_reader :handlers

    def initialize(&block)
      Dotenv.load
      ::Bundler.require(:default)
      @adapter = Adapter.adapter_classes.last.new(self)
      @handlers = []
      instance_eval(&block) if block
    end

    def listen
      @adapter.listen
    end

    def on_receive(message)
      selected_handler = handlers.find { |handler| handler.event.match?(message) }
      selected_handler.action.invoke if selected_handler
    end

    private

    def blink(handler)
      @handlers.push(handler)
    end

    # add methods for each colors
    ::Blinkman::Blink1::LED_COLORS.each_pair do |color_name, color_code|
      define_method(color_name) do |times, during, event|
        led(::Blinkman::Blink1::LED_COLORS[__method__.to_sym], times, during, event)
      end
    end

    def led(color_code, times, during, event)
      Handler.new(
        Action.new(color_code, times, during),
        event
      )
    end

    def during(millisec)
      millisec
    end

    def when_if(&block)
      Event.new(&block)
    end
  end
end
