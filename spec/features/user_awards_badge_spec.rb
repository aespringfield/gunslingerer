require 'rails_helper'

describe 'user creates new gunslinger', type: :feature do
  it 'while not logged in' do
    visit new_gunslinger_path
    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_content('You need to sign in or sign up before continuing')
  end

  it 'while logged in' do
    user = create :user
    gunslinger = build :gunslinger
    
    log_in(user)
    visit new_gunslinger_path
    fill_in 'First name', with: gunslinger.first_name
    fill_in 'Last name', with: gunslinger.last_name
    fill_in 'Email', with: gunslinger.email
    click_button 'Save'
    saved_gunslinger = Gunslinger.find(email: gunslinger.email)
    expect(page).to have_current_path(gunslinger(saved_gunslinger.id))
  end
end
