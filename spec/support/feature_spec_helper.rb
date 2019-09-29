module FeatureSpecHelper
    def log_in(user)
        visit new_user_session_path
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Log in'
    end

    def badge_images
        all('.badge-image')
    end
end