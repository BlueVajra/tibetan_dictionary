require 'spec_helper'

feature "Glossary Uploading" do

  scenario "user can upload a csv into a glossary" do
    user = create_user("bob@bob.com")
    sign_in_user(user)

    term = create_term("Existing Term")
    glossary = create_public_glossary(user)
    create_definition("Existing Definition", term, glossary)

    click_on "My Glossaries"
    click_on glossary.name

    expect(page).to have_no_content "New Term"
    expect(page).to have_content "Existing Term"
    expect(page).to have_content "Existing Definition"
    expect(page).to have_no_content "New Definition for new term"
    expect(page).to have_no_content "New Definition for existing term"

    click_on "Import Glossary"
    attach_file "file", "#{Rails.root}/spec/fixtures/somefile.csv"
    click_on "Submit"

    expect(page).to have_content "New Term"
    expect(page).to have_content "New Definition for new term"
    expect(page).to have_content "New Definition for existing term"
    expect(page).to have_content "Your records have been successfully imported"

  end

  scenario "user sees an error when uploading a malformed csv and action is rolled back/cancelled" do
    user = create_user("bob@bob.com")
    glossary = create_public_glossary(user)
    sign_in_user(user)

    click_on "My Glossaries"
    click_on glossary.name

    click_on "Import Glossary"
    attach_file "file", "#{Rails.root}/spec/fixtures/with_errors.csv"
    click_on "Submit"

    expect(page).to have_content "There was an error with the import."
    expect(page).to have_content "Illegal quoting in line 3"
    expect(page).to have_content "Please fix the problem and try again."

    click_on "My Glossaries"
    click_on glossary.name
    expect(page).to have_no_content "Term1"
    expect(page).to have_no_content "Def1"
  end

  scenario "user sees an error when uploading a csv with improper headers" do
    user = create_user("bob@bob.com")
    glossary = create_public_glossary(user)
    sign_in_user(user)

    click_on "My Glossaries"
    click_on glossary.name

    click_on "Import Glossary"
    attach_file "file", "#{Rails.root}/spec/fixtures/wrong_header.csv"
    click_on "Submit"

    expect(page).to have_content "There was an error with the import."
    expect(page).to have_content "Malformed header row"
    expect(page).to have_content "Please fix the problem and try again."

    click_on "My Glossaries"
    click_on glossary.name
    expect(page).to have_no_content "Term1"
    expect(page).to have_no_content "Def1"
  end
end