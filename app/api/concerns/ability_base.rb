module AbilityBase
  extend ActiveSupport::Concern
  included do
    helpers do

      def get_ability(id)
        @ability = JSON.parse api_get_request("/ability/#{id}")

        if !@ability || @ability['error']
          raise ApiException.new(
            http_status: RESPONSE_CODE[:not_found],
            code: RESPONSE_CODE[:not_found],
            message: I18n.t('errors.message.not_found')
          )
        end
      end

      def get_abilities(page)
        @abilities = JSON.parse api_get_request('/ability', {page: page})

        unless @abilities.present?
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
