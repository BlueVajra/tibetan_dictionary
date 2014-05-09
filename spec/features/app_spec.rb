require 'spec_helper'

feature "Manage Authentication" do
  scenario "User can register" do
    visit '/'
    click_link 'Sign up'
    fill_in 'user[email]', with: "bob@bob.com"
    fill_in 'user[password]', with: "12341234"
    fill_in 'user[password_confirmation]', with: "12341234"
    click_button 'Sign up'
    expect(page).to have_content "Welcome bob@bob.com"
  end
end