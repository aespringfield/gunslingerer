require 'credly_badge_service'

class GunslingersController < ApplicationController
    def index
        gunslingers = Gunslinger.all
        render 'index', locals: {gunslingers: gunslingers}
    end

    def new
        first_name, last_name = params[:gunslinger_name].split(' ', 2)
        last_name ||= '[No last name]'
        render 'new', locals: {
            first_name: first_name,
            last_name: last_name,
            badge_template: params[:badge_template]
        }
    end

    def create
        gunslinger_params = params.permit(
            :first_name,
            :last_name,
            :email
        )

        badge_params = params.permit(
            :badge_template_id
        )

        gunslinger = Gunslinger.new(gunslinger_params) 

        if gunslinger.save
            badge = Badge.create(gunslinger: gunslinger, badge_template_id: badge_params[:badge_template_id])
            flash[:notice] = 'Congratulations, you\'ve recruited a gunslinger'
            redirect_to gunslingers_path
        else
            flash[:notice] = gunslinger.errors
        end 
    end
end