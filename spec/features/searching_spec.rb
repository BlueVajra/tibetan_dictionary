require 'spec_helper'

feature "Search terms and see definitions" do

  scenario "user searches a term" do
    create_terms

    visit '/'
    click_on 'Dictionary'
    fill_in 'search', with: "ka pa la"
    click_button 'search_button'
    expect(page).to have_content "ka pa la"
    expect(page).to_not have_content "ka pa la la"
    expect(page).to_not have_content "bsgrubs"
  end

  scenario "user clicks on a term in a definition" do
    user = create_user("bob@bob.com")
    glossary = create_public_glossary(user)
    create_bulk_definitions_for(glossary)

    visit '/'
    click_on 'Dictionary'
    click_on "dam"
    expect(page).to have_content "Test link"
    click_on "ཆོས་"
    within(".terms") do
      click_link "chos"
    end
    expect(page).to have_content "Link to Here"
  end

  scenario "search results show both term and definition results" do
    user = create_user("bob@bob.com")
    glossary = create_public_glossary(user)
    create_bulk_definitions_for(glossary)

    visit '/'
    click_on 'Dictionary'
    fill_in 'search', with: "chos"
    click_button 'search_button'
    expect(page).to have_content "chos"
    expect(page).to have_content "dam"
    expect(page).to have_content "Search results for 'chos'"

  end

end
