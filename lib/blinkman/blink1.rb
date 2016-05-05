module Blinkman
  class Blink1

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

    attr_reader :color_code, :times, :during
    def initialize(color_code, times, during)
      @color_code = color_code
      @times = times
      @during = during
    end

    def blink
      _blink(@color_code, @times, @during)
    end

    def _blink(color_code, times, during)
      ::Blink1.open do |blink1|
        blink1.delay_millis = blink1.millis = during / times
        blink1.blink(color_code[:r], color_code[:g], color_code[:b], times)
      end
    end
  end
end
