class GunslingersController < ApplicationController
    def index
        timestamp = Time.now.to_i
        hash = Digest::MD5.hexdigest(timestamp.to_s + ENV['MARVEL_PRIVATE_KEY'] + ENV['MARVEL_PUBLIC_KEY'])
        url = "http://gateway.marvel.com/v1/public/characters?ts=#{timestamp}&apikey=#{ENV['MARVEL_PUBLIC_KEY']}&hash=#{hash}&limit=100"
        names = JSON.parse(Faraday.get(url).body)['data']['results'].map { |g| g.fetch('name') }

        render 'index', locals: {names: names}
    end

    def new
        # byebug
        @gunslinger = Gunslinger.new
    end

    def create
        # byebug
    end
end