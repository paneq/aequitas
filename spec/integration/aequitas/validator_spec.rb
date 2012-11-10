require 'spec_helper'

describe Aequitas do

  class DummyObject
    attr_reader :name, :amount
    def initialize(name, amount)
      @name, @amount = name, amount
    end
  end

  let(:object) do
    DummyObject.new(name, amount)
  end

  let(:class_under_test) do
    Class.new do
      include Aequitas

      validates_presence_of      :name
      validates_numericalness_of :amount
    end
  end

  subject { class_under_test.new(object) }

  describe 'valid attributes' do
    let(:name)   { 'John Doe' }
    let(:amount) { 815        }

    it '#valid? returns true' do
      assert_predicate subject, :valid?
    end

    it '#violations is empty' do
      assert_predicate subject.violations, :empty?
    end

    it 'violations on attributes are empty' do
      assert_predicate subject.violations.on(:name), :empty?
      assert_predicate subject.violations.on(:amount), :empty?
    end
  end

  describe 'invalid attributes' do
    let(:name)   { ''   }
    let(:amount) { 815  }

    it '#valid? returns false' do
      refute_predicate subject, :valid?
    end

#   it 'returns resource as validated object on violations' do
#     assert_same subject.violations.on(:name).first.resource, object
#   end

    it 'violations on valid attributes are empty' do
      assert_predicate subject.violations.on(:amount), :empty?
    end
  end
end
