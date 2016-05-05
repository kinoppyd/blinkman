module Blinkman
  class Action
    require 'blink1'

    attr_reader :color_code, :times, :during, :blink1

    def initialize(color_code, times,  during = 1000)
      @color_code = color_code
      @times = times
      @during = during
      @blink1 = ::Blinkman::Blink1.new(@color_code, @times.count.to_i, @during)
    end

    def invoke
      @blink1.blink
    end
  end
end
