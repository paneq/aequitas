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

  let(:validator) do
    Aequitas::Validator.build do
      validates_presence_of  :name
      validates_primitive_of :amount, :primitive => Integer
    end
  end

  subject { validator.validate(object) }

  describe 'valid attributes' do
    let(:name)   { 'John Doe' }
    let(:amount) { 815        }

    it '#valid? returns true' do
      subject.valid?.should be(true)
    end

    it 'violations on attributes are empty' do
      subject.on(:name).empty?.should be(true)
      subject.on(:amount).empty?.should be(true)
    end
  end

  describe 'invalid attributes' do
    let(:name)   { ''   }
    let(:amount) { 815  }

    its(:valid?) { should be(false) }

    it 'violations on valid attributes are empty' do
      subject.on(:amount).empty?.should be(true)
    end
  end
end
