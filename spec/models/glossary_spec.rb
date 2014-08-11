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

  describe "importing a csv" do

    it "creates a new term and new definition" do
      glossary = Glossary.create!(:name => 'Name', :description => 'Description')
      create_term("Existing Term")
      csv_file = File.open("#{Rails.root}/spec/fixtures/new_term.csv")
      initial_term_count = TibTerm.count
      initial_definition_count = Definition.count

      glossary.create_definitions_from_csv(csv_file)

      expect(TibTerm.count).to eq initial_term_count + 1
      expect(Definition.count).to eq initial_definition_count + 2

      created_term = TibTerm.last
      first_created_definition = Definition.first
      last_created_definition = Definition.last

      expect(created_term.wyl).to eq "New Term"
      expect(first_created_definition.entry).to eq "New Definition for Existing Term"
      expect(last_created_definition.entry).to eq "New Definition"
      expect(last_created_definition.glossary_id).to eq glossary.id
    end

    it "pulls out the spaces and/or apostraphies" do
      glossary = Glossary.create!(:name => 'Name', :description => 'Description')
      csv_file = File.open("#{Rails.root}/spec/fixtures/with_spaces.csv")

      glossary.create_definitions_from_csv(csv_file)

      created_term = TibTerm.last
      created_definition = Definition.first

      expect(created_term.wyl).to_not eq " New Term "
      expect(created_term.wyl).to eq "New Term"
      expect(created_definition.entry).to_not eq "\"New Definition for Existing Term\""
      expect(created_definition.entry).to eq "New Definition for Existing Term"
    end

    it "catches an error when importing malformed csv" do
      glossary = Glossary.create!(:name => 'Name', :description => 'Description')
      csv_file = File.open("#{Rails.root}/spec/fixtures/with_errors.csv")

      expect { glossary.create_definitions_from_csv(csv_file) }.to raise_error(CSV::MalformedCSVError)
    end

    it "user sees an error when trying to load a csv with too many lines" do
      glossary = Glossary.create!(:name => 'Name', :description => 'Description')
      csv_file = File.open("#{Rails.root}/spec/fixtures/too_many_lines.csv")

      expect { glossary.create_definitions_from_csv(csv_file, 10) }.to raise_error(RangeError)
    end

    it "determines if a glossary belongs to a user" do
      user = create_user("bob@bob.com")
      glossary = user.glossaries.create!(:name => 'Name', :description => 'Description')

      expect(glossary.belongs_to?(user)).to eq true

      expect(glossary.belongs_to?(create_user('sue@sue.com'))).to eq false
    end
  end
end