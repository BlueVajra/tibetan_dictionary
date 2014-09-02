require 'spec_helper'

feature "Manage Authentication" do
  context "User is signed in" do
    before :each do
      sign_up_user("bob@bob.com")
    end
    scenario "a guest can't see glossaries created by other people" do
      click_on "My Glossaries"
      click_on "Add New Glossary"
      fill_in "glossary[name]", with: "A Glossary Name"
      fill_in "glossary[description]", with: "Information about this glossary goes here"
      click_button "Add Glossary"
      expect(page).to have_content "A Glossary Name"
      click_link "Sign out"

      click_link 'Sign up'
      fill_in 'user[email]', with: "john@gmail.com"
      fill_in 'user[password]', with: "12341234"
      fill_in 'user[password_confirmation]', with: "12341234"
      click_button 'Sign up'
      click_on "My Glossaries"
      expect(page).to_not have_content "A Glossary Name"
    end
    scenario "a guest can't create Glossaries" do
      click_link 'Sign out'
      visit glossaries_path
      expect(page).to have_content "You need to sign in or sign up before continuing."
    end

  end
  context "User is not signed in" do
    scenario "guest can't add a definition" do
      @term = TibTerm.create!(wyl: "My term")
      visit tib_term_path(@term)
      expect(page).to have_content "Please register or login to add a definition"
    end
    scenario "guest can't add a comment" do
      @term = TibTerm.create!(wyl: "My term")
      visit tib_term_path(@term)
      expect(page).to have_content "Please register or login to comment"
    end
  end

end
