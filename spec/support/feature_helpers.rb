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

  end

  def create_terms
    TibTerm.create!(wyl: "ka")
    TibTerm.create!(wyl: "ka pa la")
    TibTerm.create!(wyl: "ka dag klong yangs")
    TibTerm.create!(wyl: "dag")
    TibTerm.create!(wyl: "bsgrubs")
    TibTerm.create!(wyl: "mi")
  end
end