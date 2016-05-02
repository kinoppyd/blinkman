module Blinkman
  module Adapter
    @@adapter_classes = []

    class << self
      def adapter_classes
        @@adapter_classes
      end
    end

    def build
      adapter_classes.last.new
    end
  end
end
