require 'spec_helper'

feature "Managing glossaries" do

  scenario "a new user has an empty public glossary created" do
    sign_up_user

    click_on "My Glossaries"
    expect(page).to have_content "bob@bob.com's Public Glossary"
    click_on "bob@bob.com's Public Glossary"
    expect(find("table.glossary_terms")).to_not have_selector "tr"

  end

  scenario "user can edit a glossary they created" do
    create_definitions
    sign_in_user

    click_on "My Glossaries"
    click_on "Test"
    expect(page).to have_content "Description Here"
  end

  scenario "a user's definition gets added to auto generated glossary" do
    @term = TibTerm.create!(wyl: "My term")
    sign_up_user

    visit tib_term_path(@term)

    fill_in 'definition[entry]', with: "Some entry"
    click_button "Submit"

    expect(page).to have_content("bob@bob.com's Public Glossary")
    expect(page).to have_content("Some entry")
  end


end