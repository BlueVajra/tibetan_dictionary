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
    create_definitions

    visit '/'
    click_on 'Dictionary'
    click_on "Test1"
    expect(page).to have_content "Test link"
    click_on "Test2"
    click_on "Test2"
    expect(page).to have_content "Link to Here"
  end
end
