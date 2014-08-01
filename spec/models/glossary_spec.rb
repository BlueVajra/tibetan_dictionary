require 'spec_helper'

describe Glossary do
  describe "validations" do
    before do
      @glossary = Glossary.new(:name => 'Name', :description => 'Description')
      @glossary.save
      expect(@glossary).to be_valid
    end
    it "ensures glossary name is unique" do
      @glossary = Glossary.new(:name => 'Name')
      expect(@glossary).to_not be_valid
    end
    it "ensures glossary name is not blank" do
      @glossary.name =''
      expect(@glossary).to_not be_valid
    end
  end

  describe "converting to csv" do
    it "returns a csv file for the definitions of a given glossary" do
      glossary = Glossary.create!(:name => 'Name', :description => 'Description')
      term = TibTerm.create!(:wyl => 'bsgrubs')
      glossary.definitions.new(entry: 'Accomplish', tib_term: term)
      expected = <<CSV
Term,Entry
bsgrubs,Accomplish
CSV
      expect(glossary.to_csv).to eq expected
    end
  end
end