class User < ApplicationRecord
  class << self
    def from_omniauth(auth_hash)
      user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      user.name = auth_hash['info']['name']
      user.location = get_social_location_for(user.provider, auth_hash['info']['location'])
      byebug
      user.image_url = get_social_image_for(user.provider, auth_hash)
      byebug
      user.url = get_social_url_for(user.provider, auth_hash['info']['urls'])
      user.save!
      user
    end

    private

    def get_social_location_for(provider, location_hash)
      case provider
        when 'linkedin'
          location_hash['name']
        else
          location_hash
      end
    end
    def get_social_image_for(provider, auth_hash)
      case provider
        when 'strava'
          auth_hash['extra']['raw_info']['profile']
        else
          auth_hash['info']['image']
      end
    end
    def get_social_url_for(provider, urls_hash)
      case provider
        when 'linkedin'
          urls_hash['public_profile']
        when 'strava'
          nil
        else
          urls_hash[provider.capitalize]
      end
    end
  end
end
