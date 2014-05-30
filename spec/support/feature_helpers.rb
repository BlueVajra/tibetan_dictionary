module FeatureHelpers
  def sign_up_user
    visit '/'
    click_link 'Sign up'
    fill_in 'user[email]', with: "bob@bob.com"
    fill_in 'user[password]', with: "12341234"
    fill_in 'user[password_confirmation]', with: "12341234"
    click_button 'Sign up'
  end

  def sign_in_user
    visit '/'
    click_link 'Sign in'
    fill_in 'user[email]', with: "bob@bob.com"
    fill_in 'user[password]', with: "12341234"
    click_button 'Sign in'
  end

  def create_terms
    TibTerm.create!(wyl: "ka")
    TibTerm.create!(wyl: "ka pa la")
    TibTerm.create!(wyl: "ka dag klong yangs")
    TibTerm.create!(wyl: "dag")
    TibTerm.create!(wyl: "bsgrubs")
    TibTerm.create!(wyl: "mi")
  end

  def create_definitions
    user1 = User.create!(email:"bob@bob.com", password: "12341234")
    gloss = Glossary.create!(name: "Test", description: "Description Here", user_id: user1.id)
    term1 = TibTerm.create!(wyl: "Test1")
    term2 = TibTerm.create!(wyl: "Test2")

    Definition.create!(
      entry: %q{ Test link {Test2} },
      tib_term_id: term1.id,
      glossary_id: gloss.id
    )
    Definition.create!(
      entry: "Link to Here",
      tib_term_id: term2.id,
      glossary_id: gloss.id
    )

  end

  def create_private_definitions
    user1 = User.create!(email:"bob@bob.com", password: "12341234")
    user2 = User.create!(email:"joe@joe.com", password: "12341234")
    gloss = Glossary.create!(name: "Test", description: "Description Here", user_id: user1.id)
    gloss2 = Glossary.create!(name: "Private Test", description: "Description Here", user_id: user2.id, private: true)

    term1 = TibTerm.create!(wyl: "Test1")

    Definition.create!(
      entry: "Entry 1",
      tib_term_id: term1.id,
      glossary_id: gloss.id
    )
    Definition.create!(
      entry: "Entry 2",
      tib_term_id: term1.id,
      glossary_id: gloss.id
    )
    Definition.create!(
      entry: "Entry 3",
      tib_term_id: term1.id,
      glossary_id: gloss2.id
    )

  end
end