module V1
  class Abilities < Grape::API
    include V1Base
    include AbilityBase

    resource :abilities do

      desc 'Get all abilities', {
        consumes: [ "application/x-www-form-urlencoded" ],
        http_codes: [
          { code: 200, message: 'success' }
        ]
      }
      params do
        optional :page, type: Integer, desc: 'page'
      end

      get do
        page = (params[:page] || 1).to_i
        get_abilities(page)
        render_success(@abilities['data'].as_json, pagination_dict_from_hash(@abilities))
      end

      desc 'Get Ability', http_codes: [
        { code: 200, message: 'success' },
        { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }
      ]
      params do
        requires :id, type: String, desc: 'Ability id'
      end
      get ':id' do
        get_ability(params[:id])
        render_success(@ability.as_json)
      end


    end
  end
end

