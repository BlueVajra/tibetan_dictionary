require 'spec_helper'

describe Definition do
  describe "validations" do
    before do
      @definition = Definition.new(entry: 'Test', name: 'Cory')
      expect(@definition).to be_valid
    end
    it "ensures entry is not blank" do
      @definition.entry = ''
      expect(@definition).to_not be_valid
    end
    it "ensures name is not blank" do
      @definition.name = ''
      expect(@definition).to_not be_valid
    end
  end
end