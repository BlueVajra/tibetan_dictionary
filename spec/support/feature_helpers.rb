module FeatureHelpers
  def sign_up_user(email)
    visit '/'
    click_link 'Sign up'
    fill_in 'user[username]', with: email
    fill_in 'user[email]', with: email
    fill_in 'user[password]', with: "12341234"
    fill_in 'user[password_confirmation]', with: "12341234"
    click_button 'Sign up'
  end

  def sign_in_user(user)
    visit '/'
    click_link 'Sign in'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: "password1"
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

  def create_bulk_definitions_for(glossary)
    term1 = TibTerm.create!(wyl: "dam")
    term2 = TibTerm.create!(wyl: "chos")

    Definition.create!(
      entry: %q{Test link {chos}},
      tib_term_id: term1.id,
      glossary_id: glossary.id
    )
    Definition.create!(
      entry: "Link to Here",
      tib_term_id: term2.id,
      glossary_id: glossary.id
    )
  end

  def create_searching_definitions_for(glossary)
    term1 = TibTerm.create!(wyl: "dam")
    term2 = TibTerm.create!(wyl: "chos")
    term3 = TibTerm.create!(wyl: "test1")

    Definition.create!(
      entry: %q{Test link {chos}},
      tib_term_id: term1.id,
      glossary_id: glossary.id
    )
    Definition.create!(
      entry: "Link to Here",
      tib_term_id: term2.id,
      glossary_id: glossary.id
    )
    Definition.create!(
      entry: "chos abcd efgh ijkl mnop qrst uvwxyz 1234 5678 90111",
      tib_term_id: term3.id,
      glossary_id: glossary.id
    )
  end

  def convert_pdf_to_page
    temp_pdf = Tempfile.new('pdf')
    temp_pdf << page.source.force_encoding('UTF-8')
    reader = PDF::Reader.new(temp_pdf)
    pdf_text = reader.pages.map(&:text)
    page.driver.response.instance_variable_set('@body', pdf_text)
  end

end
