require 'marvel_characters_service'

class RecruitsController < ApplicationController
    def index
        recruits = MarvelCharactersService::get_characters
        render 'index', locals: {recruits: recruits}
    end
end