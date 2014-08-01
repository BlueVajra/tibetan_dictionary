require 'spec_helper'

feature "Managing glossaries" do

  scenario "a new user has an empty public glossary created" do
    sign_up_user("bob@bob.com")

    click_on "My Glossaries"
    click_on "bob@bob.com's Public Glossary"
    expect(find("table.glossary_terms")).to_not have_selector "tr"
  end

  scenario "user can manage a glossary" do
    sign_up_user("bob@bob.com")

    click_on "My Glossaries"
    click_on "Add New Glossary"
    fill_in 'glossary[name]', with: "My Great Words"
    fill_in 'glossary[description]', with: "A great description"
    check 'glossary[private]'
    click_button 'Add Glossary'

    expect(page).to have_content "My Great Words"
    expect(page).to have_content "private"

    click_on "My Glossaries"
    click_on "My Great Words"
    expect(page).to have_content "A great description"
    click_on "Edit Glossary"
    fill_in 'glossary[name]', with: "Changed Glossary name"
    fill_in 'glossary[description]', with: "New Description goes here"
    click_button 'Update'

    expect(page).to have_content "Changed Glossary name"
  end

  scenario "a user can see if glossary is default and change default to another" do
    sign_up_user("bob@bob.com")
    user = User.find_by(email: "bob@bob.com")
    create_public_glossary(user, "Glossary not initially default")

    click_on "My Glossaries"
    expect(find("table.glossary_list tr:nth-child(2)")).to have_content "default"
    within("table.glossary_list tr:nth-child(3)") do
      click_on "make default"
    end
    expect(find("table.glossary_list tr:nth-child(2)")).to have_content "make default"
    expect(find("table.glossary_list tr:nth-child(3)")).to have_content "default"
  end

  scenario "user can edit (or cancel editing) definitions from their glossary", js: true do
    user = create_user("bob@bob.com")
    sign_in_user(user)
    glossary = create_public_glossary(user, "Glossary Test 1")
    create_bulk_definitions_for(glossary)

    click_on 'My Glossaries'
    click_on "Glossary Test 1"

    within("table.glossary_terms tr:nth-child(1)") do
      click_on "edit"
    end

    fill_in 'definition[entry]', with: "New and Improved"
    click_on "Cancel"
    expect(page).to_not have_content "New and Improved"

    within("table.glossary_terms tr:nth-child(1)") do
      click_on "edit"
    end

    fill_in 'definition[entry]', with: "Really New and Improved"
    click_on "✓"
    expect(page).to have_content "Really New and Improved"
  end

  scenario "user can download a csv of a glossary" do
    user = create_user("bob@bob.com")
    sign_in_user(user)

    glossary = create_public_glossary(user)
    create_bulk_definitions_for(glossary)

    click_on 'My Glossaries'
    click_on glossary.name
    click_on "Download CSV"

    expect(page.source).to eq(<<-CSV)
Term,Entry
dam,Test link {chos}
chos,Link to Here
    CSV
  end

end