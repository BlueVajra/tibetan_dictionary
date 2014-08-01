require 'spec_helper'

describe Definition do
  describe "validations" do
    it "ensures entry is not blank" do
      @definition = Definition.new(entry: 'Test', glossary_id: 1, tib_term_id: 1)
      expect(@definition).to be_valid

      @definition.entry = ''
      expect(@definition).to_not be_valid
    end
  end

end