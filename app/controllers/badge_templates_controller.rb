require 'credly_badge_service'

class BadgeTemplatesController < ApplicationController
    def index
        badge_templates = CredlyBadgeService::get_badge_templates

        render 'index', locals: {
            badge_templates: badge_templates,
            gunslinger_name: params[:gunslinger_name]
        }
    end
end