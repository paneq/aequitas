require 'pathname'
__dir__ = Pathname(__FILE__).dirname.expand_path

require __dir__.parent.parent + 'spec_helper'
require __dir__ + 'spec_helper'


describe DataMapper::Validate::Fixtures::LerneanHydra do
  describe "with valid set of attributes" do
    before :all do
      @model = DataMapper::Validate::Fixtures::LerneanHydra.valid_instance
      @model.valid?
    end

    it_should_behave_like "valid model"
  end


  describe "with 9 heads" do
    before :all do
      @model = DataMapper::Validate::Fixtures::LerneanHydra.valid_instance(:head_count => 9)
      @model.valid?
    end

    it_should_behave_like "valid model"
  end


  describe "with only 3 heads" do
    before :all do
      @model = DataMapper::Validate::Fixtures::LerneanHydra.valid_instance(:head_count => 3)
      @model.valid?
    end

    it_should_behave_like "invalid model"

    it "has a meaningful error message" do
      @model.errors.on(:head_count).should include("Lernean hydra is said to have exactly 9 heads")
    end
  end
end