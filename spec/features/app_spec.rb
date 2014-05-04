require 'spec_helper'

feature "Manage Home and About pages" do
  scenario "User can add Terms" do

    visit '/'
    expect(page).to have_content "Welcome!"

  end
end