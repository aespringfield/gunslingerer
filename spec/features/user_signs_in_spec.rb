require 'rails_helper'

describe 'user signs in', type: :feature do
  it 'as a new user' do
    user = build :user

    visit '/users/sign_in'
    click_link 'Sign up'
    expect(page).to have_content('Sign up')
    expect(page).not_to have_content('Log out')

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button 'Sign up'
    expect(page).to have_content 'You have signed up successfully'
    expect(page).to have_content 'Gunslingers'

    # Now check that these credentials are valid for sign in
    click_link 'Log out'
    expect(page).to have_content('Log in')
    
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    expect(page).to have_content 'Gunslingers'
  end

  it 'as an existing user' do
    user = create :user
    log_in(user)
    expect(page).to have_content 'Gunslingers'
  end
end
