require 'rails_helper'

RSpec.feature "User", type: :feature do
  let(:user) {create(:user)}

  scenario "can login" do
    visit(root_path)
    fill_in "user[username]", with: user.username
    fill_in "user[password]", with: user.password
    click_on('Login')

    expect(page).to have_content("Logged in as #{user.username}")
    expect(page).not_to have_content("Login")
    expect(page).to have_content("Logout")
  end

  scenario "fails to login" do
    visit(root_path)
    fill_in 'user[username]', with: user.username
    fill_in 'user[password]', with: 'badpassword'
    click_on('Login')

    expect(page).to have_current_path(root_path)
    expect(page).to have_content('Login Failed')
  end
end