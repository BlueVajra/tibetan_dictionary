require 'spec_helper'

feature "Managing glossaries" do

  scenario "a new user has an empty public glossary created" do
    sign_up_user

    click_on "My Glossaries"
    expect(page).to have_content "bob@bob.com's Public Glossary"
    click_on "bob@bob.com's Public Glossary"
    expect(find("table.glossary_terms")).to_not have_selector "tr"

  end

  scenario "user can create a glossary" do
    create_definitions
    #sign_in_user

    click_on "My Glossaries"
    click_on "Add New Glossary"
    fill_in 'glossary[name]', with: "New Glossary"
    fill_in 'glossary[description]', with: "New Description goes here"
    check 'glossary[private]'
    click_button 'Add Glossary'

    expect(page).to have_content "New Glossary"
    expect(page).to have_content "private"
  end

  scenario "User cannot see entries for private glossaries" do
    create_private_definitions
    #sign_in_user

    click_on "Dictionary"
    click_on "Test1"

    expect(page).to have_content "Entry 1"
    expect(page).to_not have_content "Entry 3"
  end

  scenario "user can edit a glossary they created" do
    create_definitions
    #sign_in_user

    click_on "My Glossaries"
    click_on "Test"
    expect(page).to have_content "Description Here"
    click_on "Edit Glossary"
    fill_in 'glossary[name]', with: "Test New"
    fill_in 'glossary[description]', with: "New Description goes here"
    click_button 'Update'

    expect(page).to have_content "Test New"
  end

  scenario "a user's definition gets added to default glossary" do
    create_private_definitions

    visit '/tib_terms'
    click_on 'Test1'

    fill_in 'definition[entry]', with: "Some entry"
    click_button "Submit"

    expect(page).to have_content("bob@bob.com's Public Glossary")
    expect(page).to have_content("Some entry")

    # user selects other glossary
    # user adds new definition
    #expect definition to appear in different glossary
  end

  scenario "a user can see if glossary is default and change default to another" do
    create_private_definitions
    visit '/'
    click_on "My Glossaries"
    expect(find("table.glossary_list tr:nth-child(2)")).to have_content "default"
    within("table.glossary_list tr:nth-child(3)") do
      click_on "make default"
    end
    expect(find("table.glossary_list tr:nth-child(2)")).to have_content "make default"
    expect(find("table.glossary_list tr:nth-child(3)")).to have_content "default"
  end


  scenario "a user can change the glossary they want to add a definition to on the term page" do
    @term = TibTerm.create!(wyl: "My term")
    create_private_definitions

    visit tib_term_path(@term)

    page.select 'Test 2', :from => 'definition[glossary_id]'
    fill_in 'definition[entry]', with: "Some entry"
    click_button "Submit"

    expect(page).to have_content("Test 2")
    expect(page).to have_content("Some entry")
  end

end