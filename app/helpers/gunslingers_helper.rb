require 'credly_badge_service'

module GunslingersHelper
    def badge_image_url(gunslinger)
        return if gunslinger.badges.empty?

        @badge_template ||= CredlyBadgeService.get_badge_template(badge: gunslinger.badges.first)
        @badge_template['image_url']
    end

    def default_email_address(first_name, last_name)
        "#{first_name.downcase}.#{last_name&.split&.first&.downcase}@example.com"
    end
end