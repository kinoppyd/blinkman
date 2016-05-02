$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'blinkman'

class ::Blinkman::Adapter::ForTest < ::Blinkman::Adapter::Base
  def initialize(bot)
    super
  end

  def listen
  end
end

class ::Blinkman::Message::ForTest < ::Blinkman::Message::Base
  def body
    original_message
  end
end
