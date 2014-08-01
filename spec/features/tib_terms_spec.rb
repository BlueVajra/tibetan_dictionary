require 'spec_helper'

feature "Manage Terms" do

  scenario "user can add definitions to terms" do
    sign_up_user("bob@bob.com")
    create_term("bod")
    click_link 'Dictionary'

    click_link 'bod'
    click_link 'Add Definition'
    fill_in 'definition[entry]', with: 'Tibet'
    click_button 'Submit'
    expect(page).to have_content 'Tibet'
    expect(page).to have_content "bob@bob.com's Public Glossary"

  end

  scenario "user can add comments to terms and see them when they revisit the page", js: true do
    sign_up_user("bob@bob.com")
    create_term("bod")
    click_link 'Dictionary'

    click_link 'bod'
    fill_in 'comment[title]', with: 'Title Comment'
    fill_in 'comment[body]', with: 'body of the comment'
    click_button 'Post'
    expect(page).to have_content 'Title Comment'

    click_link "Dictionary"
    click_link "bod"

    expect(page).to have_content 'Title Comment'
  end

  scenario "User cannot see entries for a term that are in a private glossary" do
    term = create_term("bod")
    create_definition("Tibet, the country", term, create_private_glossary(create_user("joe@joe.com")))
    create_definition("Land of Snows", term, create_public_glossary(create_user("kyle@kyle.com")))

    user = create_user("bob@bob.com")
    sign_in_user(user)

    visit tib_term_path(term)

    expect(page).to have_content "kyle@kyle.com's New Public Glossary"
    expect(page).to_not have_content "joe@joe.com's Private Glossary"
  end

  scenario "a user's definition gets added to default glossary" do
    term = create_term("bod")
    sign_up_user("bob@bob.com")

    visit tib_term_path(term)

    fill_in 'definition[entry]', with: "Some entry"
    click_button "Submit"

    expect(page).to have_content("bob@bob.com's Public Glossary")
    expect(page).to have_content("bod")
    expect(page).to have_content("Some entry")
  end

  scenario "a user can change the glossary they want to add a definition to on the term page" do
    term = create_term("bod")
    user = create_user("bob@bob.com")
    sign_in_user(user)
    create_private_glossary(user, "Bob's Glossary 1")
    create_public_glossary(user, "Bob's Glossary 2")

    visit tib_term_path(term)

    page.select "Bob's Glossary 2", :from => 'definition[glossary_id]'
    fill_in 'definition[entry]', with: "Some entry"
    click_button "Submit"

    expect(page).to have_content("Bob's Glossary 2")
    expect(page).to have_content("Some entry")
  end

end