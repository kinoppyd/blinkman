require 'dotenv'

module Blinkman
  class Bot

    LED_COLORS = {
      :red => {r: 255, g: 0, b: 0},
      :green => {r: 0, g: 255, b: 0},
      :blue => {r: 0, g: 0, b: 255},
      :white => {r: 255, g: 255, b: 255},
      :gray => {r: 128, g: 128, b: 128},
      :purple => {r: 128, g: 0, b: 128},
      :yellow => {r: 255, g: 255, b: 0},
      :navy => {r: 0, g: 0, b: 128},
      :aqua => {r: 0, g: 255, b: 255},
    }

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
    LED_COLORS.each_pair do |color_name, color_code|
      define_method(color_name) do |times, during, event|
        led(LED_COLORS[__method__.to_sym], times, during, event)
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
