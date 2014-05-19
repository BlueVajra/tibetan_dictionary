require 'spec_helper'

describe Definition do
  describe "validations" do
    before do
      @definition = Definition.new(entry: 'Test', glossary_id: 1, tib_term_id: 1)
      expect(@definition).to be_valid
    end
    it "ensures entry is not blank" do
      @definition.entry = ''
      expect(@definition).to_not be_valid
    end

  end
end