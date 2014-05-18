require 'spec_helper'

feature "Manage Authentication" do
  before :each do
    visit '/'
    click_link 'Sign up'
    fill_in 'user[email]', with: "bob@bob.com"
    fill_in 'user[password]', with: "12341234"
    fill_in 'user[password_confirmation]', with: "12341234"
    click_button 'Sign up'
    expect(page).to have_content "Welcome bob@bob.com"
  end
  scenario "Signed in user can create Glossaries" do
    click_on "My Glossaries"
    click_on "Add New Glossary"
    fill_in "glossary[name]", with: "A Glossary Name"
    fill_in "glossary[description]", with: "Information about this glossary goes here"
    click_button "Add Glossary"
    expect(page).to have_content "A Glossary Name"


  end
end