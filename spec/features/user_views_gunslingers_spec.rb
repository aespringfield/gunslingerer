require 'rails_helper'

describe 'user views gunslingers', type: :feature do
  it 'while not logged in' do
    visit '/gunslingers'
    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_content('You need to sign in or sign up before continuing')
    expect(page).not_to have_content('Dashboard')
  end
end
