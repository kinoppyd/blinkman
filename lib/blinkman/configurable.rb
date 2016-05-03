module Blinkman
  module Configurable

    def initialize(*arg, &block)
      self.class.class_variable_get(:@@configured_keys).each do |key|
        upcased_key = key.upcase
        raise RuntimeError.new("key #{upcased_key} in ENV required") unless ENV.has_key?(upcased_key)
      end
      super(*arg, &block)
    end

    class << self
      def included(klass)
        klass.send(:class_variable_set, :@@configured_keys, [])

        class << klass
          def configure(key, opts = {})
            opts = { optional: false }.merge(opts)

            if ! opts[:optional]
              keys = send(:class_variable_get, :@@configured_keys)
              keys << key
              send(:class_variable_set, :@@configured_keys, keys)
            end

            define_method(key.downcase) do
              ENV[__method__.to_s.upcase]
            end
          end
        end
      end
    end
  end
end
