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
end