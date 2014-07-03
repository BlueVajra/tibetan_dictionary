require 'spec_helper'

feature "Manage Terms" do
  before do
    visit '/'
    click_link 'Sign up'
    fill_in 'user[email]', with: "bob@bob.com"
    fill_in 'user[password]', with: "12341234"
    fill_in 'user[password_confirmation]', with: "12341234"
    click_button 'Sign up'

    click_link 'Dictionary'
    click_link 'Add New Term'
    fill_in 'tib_term[wyl]', with: 'bod '
    fill_in 'tib_term[tib]', with: 'བོད་'
    click_button 'Submit'
    expect(page).to have_content 'bod'
  end
  scenario "user can add definitions to terms" do
    click_link 'bod'
    click_link 'Add Definition'
    fill_in 'definition[entry]', with: 'Tibet'
    click_button 'Submit'
    expect(page).to have_content 'Tibet'
    expect(page).to have_content "bob@bob.com's Public Glossary"

  end

end