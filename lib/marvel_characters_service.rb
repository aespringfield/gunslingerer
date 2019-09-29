module MarvelCharactersService
    def self.get_characters(
        name_starts_with: 'a',
        marvel_private_key: ENV['MARVEL_PRIVATE_KEY'],
        marvel_public_key: ENV['MARVEL_PUBLIC_KEY']
    )
        timestamp = Time.now.to_i
        hash = Digest::MD5.hexdigest(timestamp.to_s + marvel_private_key + marvel_public_key)
        url = "http://gateway.marvel.com/v1/public/characters?ts=#{timestamp}&apikey=#{ENV['MARVEL_PUBLIC_KEY']}&hash=#{hash}&nameStartsWith=#{name_starts_with}&limit=100"
        JSON.parse(Faraday.get(url).body)['data']['results']
    end
end