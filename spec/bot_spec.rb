require 'spec_helper'

describe Blinkman::Bot do
  before do
    @blinkman = Blinkman::Bot.new do
      blink red 2.times, during(1000), when_if { |message| message.body == 'test' }
      blink blue 10.times, during(500), when_if { |message| message.body == 'hoge' }
    end
  end

  it 'can build correct sorted handlers' do
    expect(@blinkman.handlers.first.action.times.size).to eq(2.times.size)
    expect(@blinkman.handlers.first.action.during).to eq(1000)
    expect(@blinkman.handlers.first.action.color_code).to eq({r: 255, g: 0, b: 0})

    expect(@blinkman.handlers.last.action.times.size).to eq(10.times.size)
    expect(@blinkman.handlers.last.action.during).to eq(500)
    expect(@blinkman.handlers.last.action.color_code).to eq({r: 0, g: 0, b: 255})
  end

  describe 'invoke action when correct message' do
    before do
      @mock_action = double('Action')
      @mock_message = double('Message')
      allow(@mock_message).to receive(:body).and_return('hoge')
    end
    it 'callse invoke method' do
      expect(@mock_action).to receive(:invoke).once

      @blinkman.handlers.last.instance_variable_set(:@action, @mock_action)
      @blinkman.on_receive(@mock_message)
    end

    it 'is not callse unexpected invoke method' do
      expect(@mock_action).to receive(:invoke).exactly(0).times

      mock_action2 = double("Action2")
      allow(mock_action2).to receive(:invoke)
      @blinkman.handlers.first.instance_variable_set(:@action, @mock_action)
      @blinkman.handlers.last.instance_variable_set(:@action, mock_action2)
      @blinkman.on_receive(@mock_message)
    end
  end
end
