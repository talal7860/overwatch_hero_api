module HeroBase
  extend ActiveSupport::Concern
  included do
    helpers do
      def get_hero(id)
        @hero = JSON.parse api_get_request("/hero/#{id}")

        if !@hero || @hero['error']
          raise ApiException.new(
            http_status: RESPONSE_CODE[:not_found],
            code: RESPONSE_CODE[:not_found],
            message: I18n.t('errors.message.not_found')
          )
        end
      end

      def get_heroes(page)
        @heroes = JSON.parse api_get_request('/hero', {page: page})
        unless @heroes
          raise ApiException.new(
            http_status: RESPONSE_CODE[:not_found],
            code: RESPONSE_CODE[:not_found],
            message: I18n.t('errors.message.not_found')
          )
        end
      end

    end
  end
end
