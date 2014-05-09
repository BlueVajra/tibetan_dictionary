require 'spec_helper'

feature 'Definitions' do
  scenario "User can add a definition to a term" do
    term = TibTerm.create!(wyl: "My term")

    visit tib_term_path(term)

    fill_in 'definition[name]', with: "Some name"
    fill_in 'definition[entry]', with: "Some entry"

    click_button "Submit"

    expect(page).to have_content("Some name")
    expect(page).to have_content("Some entry")
  end
end