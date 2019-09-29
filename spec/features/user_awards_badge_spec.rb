require 'rails_helper'

describe 'user awards badge', type: :feature do
  it 'while not logged in' do
    visit badge_templates_path
    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_content('You need to sign in or sign up before continuing')
  end

  it 'while logged in' do
    user = create :user
    gunslinger = build :gunslinger
    
    log_in(user)

    visit gunslingers_path
    click_link 'Recruit a new gunslinger'
    expect(page).to have_content('Recruits', wait: 5)

    click_link 'Absorbing Man'
    expect(page).to have_content('Select a badge', wait: 5)

    click_link 'Anna1'
    expect(page).to have_content('Submit info for badging', wait: 5)

    fill_in('First name', with: gunslinger.first_name, wait: 5)
    fill_in 'Last name', with: gunslinger.last_name
    fill_in 'Email', with: gunslinger.email
    click_button 'Save'
    expect(page).to have_content('Gunslingers', wait: 5)
    expect(page).to have_content gunslinger.first_name
    expect(page).to have_content gunslinger.last_name
    expect(badge_images.length).to be 1
    expect(badge_images.first['src']).to eq 'https://sandbox-images.youracclaim.com/images/956bb399-c105-4a14-81f2-b81ac50572cd/blob.png'
  end
end
