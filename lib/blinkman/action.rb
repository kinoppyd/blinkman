module Blinkman
  class Action
    require 'blink1'

    attr_reader :color_code, :times, :during

    def initialize(color_code, times,  during = 1000)
      @color_code = color_code
      @times = times
      @during = during
    end

    def invoke
      color_code = @color_code
      times =  @times.count.to_i
      during = @during

      Blink1.open do |blink1|
        blink1.delay_millis = blink1.millis = during / times
        blink1.blink(color_code[:r], color_code[:g], color_code[:b], times)
      end
    end
  end
end
