require 'spec_helper'

feature "Manage Terms" do
  scenario "User can add Terms" do

    visit '/'
    click_link 'Dictionary'
    click_link 'Add New Term'
    fill_in 'tib_term[wyl]', with: 'bod '
    fill_in 'tib_term[tib]', with: 'བོད་'
    click_button 'Submit'
    expect(page).to have_content 'bod'
  end
end