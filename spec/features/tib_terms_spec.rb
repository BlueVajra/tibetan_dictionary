require 'spec_helper'

feature "Manage Terms" do
  before do

    visit '/'
    click_link 'Dictionary'
    click_link 'Add New Term'
    fill_in 'tib_term[wyl]', with: 'bod '
    fill_in 'tib_term[tib]', with: 'བོད་'
    click_button 'Submit'
    expect(page).to have_content 'bod'
  end
  scenario "user can add definitions to terms" do
    click_link 'bod'

    fill_in 'definition[entry]', with: 'Tibet'
    fill_in 'definition[name]', with: 'Cory'
    click_button 'Submit'
    expect(page).to have_content 'Tibet'
    expect(page).to have_content 'Cory'

  end
end