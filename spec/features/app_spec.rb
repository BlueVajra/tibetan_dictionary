require 'spec_helper'

feature "Manage Words" do
  scenario "User can add words" do

    visit '/'
    expect(page).to have_content "Welcome!"

  end
end