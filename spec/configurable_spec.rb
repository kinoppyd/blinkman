require 'spec_helper'

describe Blinkman::Configurable do
  describe 'configurable class' do
    context 'environment variable exists' do
      before do
        ENV['TEST_KEY'] = 'exists!'
        ENV['OTHER_TEST_KEY'] = 'exists!'
        class KeyExistsClass
          include Blinkman::Configurable
          configure 'TEST_KEY'
          configure 'other_test_key'
        end
      end

      it 'is not raises any error upcase and donwcase either' do
        expect { KeyExistsClass.new }.to_not raise_error
      end

      it 'has method to return configured value (upcase configure)' do
        expect(KeyExistsClass.new.test_key).to eq('exists!')
      end

      it 'has method to return configured value (downcase configure)' do
        expect(KeyExistsClass.new.other_test_key).to eq('exists!')
      end

      after do
        ENV.delete('TEST_KEY')
      end
    end

    context 'environment variable not exists' do
      before do
        class KeyNotExistsClass
          include Blinkman::Configurable
          configure 'TEST_KEY'
        end
      end

      it 'is raises a RuntimeError' do
        expect { KeyNotExistsClass.new }.to raise_error(RuntimeError)
      end
    end
  end

  describe 'configured class indipendency' do
    before do
      ENV['KEY1'] = 'exists!'
      class IndependentClass1
        include Blinkman::Configurable
        configure 'key1'
      end

      class IndependentClass2
        include Blinkman::Configurable
        configure 'key2'
      end
    end

    context 'key exists class' do
      it 'is not raises error' do
        expect { IndependentClass1.new }.to_not raise_error
      end
    end

    context 'key not exists class' do
      it 'is raises error' do
        expect { IndependentClass2.new }.to raise_error(RuntimeError)
      end
    end

    after do
      ENV.delete('TEST_KEY')
    end
  end

  describe "do not destruction super class's initialize method" do
    before do
      class NotDestructedClass
        include Blinkman::Configurable

        attr_reader :arg1, :arg2
        def initialize(arg1, arg2, &block)
          @arg1 = arg1
          @arg2 = arg2
          @block = block
        end

        def call
          @block.call
        end
      end

      @instance = NotDestructedClass.new('test', 'foo') do
        raise RuntimeError
      end
    end

    it 'can read args' do
      expect(@instance.arg1).to eq('test')
      expect(@instance.arg2).to eq('foo')
    end

    it 'can call block' do
      expect { @instance.call }.to raise_error(RuntimeError)
    end

    after do
      @instance = nil
    end
  end
end
