require 'spec_helper'

describe TibTerm do
  describe "validations" do
    before do
      @term = TibTerm.new(:wyl => 'bsgrubs')
      @term.save
      expect(@term).to be_valid
    end
    it "ensures term is unique" do
      @term = TibTerm.new(:wyl => 'bsgrubs')
      expect(@term).to_not be_valid
    end
    it "ensures terms with whitespace at end are treated same" do
      pending
      @term = TibTerm.new
      @term.wyl = 'bsgrubs '
      expect(@term).to_not be_valid
    end
    it "ensures wylie term is not blank" do
      @term.wyl =''
      expect(@term).to_not be_valid
    end
  end
end