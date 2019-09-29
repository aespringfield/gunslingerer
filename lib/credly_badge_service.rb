module CredlyBadgeService
    CREDLY_BASE_URL = 'https://sandbox-api.youracclaim.com/v1'

    def self.get_badge_templates(
      organization_id: ENV['CREDLY_ORGANIZATION_ID'],
      auth_token: ENV['CREDLY_AUTH_TOKEN'],
      **opts
    )
      path = "organizations/#{organization_id}/badge_templates"
      response = faraday_connection(auth_token).get(path) do |req|
        opts.each do |key, value|
          req.params[key.to_s] = value
        end
      end

      JSON.parse(response.body)['data']
    end

    def self.get_badge_template(
      badge:,
      organization_id: ENV['CREDLY_ORGANIZATION_ID'],
      auth_token: ENV['CREDLY_AUTH_TOKEN']
    )
      path = "organizations/#{organization_id}/badge_templates/#{badge.badge_template_id}"
      response = faraday_connection(auth_token).get(path)

      JSON.parse(response.body)['data']
    end

    def self.get_badge(
      gunslinger:,
      organization_id: ENV['CREDLY_ORGANIZATION_ID'],
      auth_token: ENV['CREDLY_AUTH_TOKEN'],
      **opts
    )
      path = "organizations/#{organization_id}/badges"
      params = opts.symbolize_keys
      filters = ["issuer_earner_id::#{gunslinger.id}"]
      filters << params[:filter] unless params[:filter].nil?
      params[:filter] = filters.join('|')

      response = faraday_connection(auth_token).get(path) do |req|
        params.each do |key, value|
          req.params[key.to_s] = value
        end
      end

      JSON.parse(response.body)
    end

    def self.post_badge(
      gunslinger:,
      badge_template_id:,
      organization_id: ENV['CREDLY_ORGANIZATION_ID'],
      auth_token: ENV['CREDLY_AUTH_TOKEN'],
      **opts
    )
      path = "organizations/#{organization_id}/badges"
      body = {
        recipient_email: gunslinger.email,
        issued_to_first_name: gunslinger.first_name,
        issued_to_last_name: gunslinger.last_name,
        issuer_earner_id: gunslinger.id,
        badge_template_id: badge_template_id,
        issued_at: Time.now,
        **opts
      }
      faraday_connection(auth_token).post(path) do |req|
        req.body = body.to_json
      end
    end

    private
    
    def self.faraday_connection(auth_token)
        encoded_auth = Base64.encode64("#{auth_token}:") 
        Faraday.new(
          url: CREDLY_BASE_URL,
          headers: { 'Authorization' => "Basic #{encoded_auth}" }
        )
    end
end