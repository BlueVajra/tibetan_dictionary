require 'spec_helper'

feature "Managing glossaries" do
  before :each do
    sign_up_user
  end
  scenario "a new user has an empty public glossary created" do
    click_on "My Glossaries"
    expect(page).to have_content "bob@bob.com's Public Glossary"
    click_on "bob@bob.com's Public Glossary"
    expect(find("ul.terms")).to_not have_selector "li"

    expect(page).to have_content "List of Terms"
  end
  scenario "user sees list of glossaries created with links to the glossary" do
    click_on "My Glossaries"

  end
  context "user creates a new definition" do
    before :each do
      @term = TibTerm.create!(wyl: "My term")
    end
    scenario "a user's definition gets added to auto generated glossary" do

      visit tib_term_path(@term)

      fill_in 'definition[entry]', with: "Some entry"

      click_button "Submit"

      expect(page).to have_content("bob@bob.com's Public Glossary")
      expect(page).to have_content("Some entry")
    end
    scenario "a user create"

  end

end