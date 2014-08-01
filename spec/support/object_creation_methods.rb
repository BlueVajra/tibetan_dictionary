module ObjectCreationMethods
  def create_user(email)
    User.create(email: email, password: "password1")
  end

  def create_term(term)
    TibTerm.create!(wyl: term)
  end

  def create_definition(definition_entry, term, glossary)
    Definition.create!(
      entry: definition_entry,
      tib_term: term,
      glossary: glossary
    )
  end

  def create_private_glossary(user, name = "#{user.email}'s Private Glossary")
    Glossary.create!(
      name: name,
      description: "#{user.email}'s Description Here",
      user: user,
      private: true
    )
  end

  def create_public_glossary(user, name = "#{user.email}'s New Public Glossary")
    Glossary.create!(
      name: name,
      description: "#{user.email}'s Description Here",
      user: user,
      private: false
    )
  end

end