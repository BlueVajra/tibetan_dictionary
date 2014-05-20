require 'spec_helper'

feature "Manage Authentication" do
  context "User is signed in" do
    before :each do
      sign_up_user
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
    scenario "a guest can't create Glossairies" do
      click_link 'Sign out'
      visit glossaries_path
      expect(page).to have_content "You need to sign in or sign up before continuing."
    end
    scenario "a new user has a public glossary created" do
      click_on "My Glossaries"
      expect(page).to have_content "bob@bob.com's Public Glossary"
    end
    context "user creates a new definition" do
      before :each do
        @term = TibTerm.create!(wyl: "My term")
      end
      scenario "a user's definition gets added to auto generated glossary" do

        visit tib_term_path(@term)

        fill_in 'definition[entry]', with: "Some entry"

        click_button "Submit"

        expect(page).to have_content("bob@bob.com's Public Glossary")
        expect(page).to have_content("Some entry")
      end
      scenario "a user create"

    end
  end
  context "User is not signed in" do
    before :each do
      @term = TibTerm.create!(wyl: "My term")
    end
    scenario "guest can't add a definition" do
      visit tib_term_path(@term)
      expect(page).to have_content "Please register or login to add a definition"
    end
  end

  scenario "user searches a term" do
    create_terms
    visit '/'
    click_on 'Dictionary'
    fill_in 'search', with: "ka"
    click_on 'Search'
    expect(page).to have_content "ka pa la"
    expect(page).to have_content "ka dag klong yangs"
    expect(page).to_not have_content "bsgrubs"
  end
end
