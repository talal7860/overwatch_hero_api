module V1
  class Hero < Grape::API
    include V1Base
    include HeroBase

    resource :heros do

      desc 'Get Heroes', http_codes: [
        { code: 200, message: 'success' },
        { code: RESPONSE_CODE[:forbidden], message: I18n.t('errors.forbidden') }
      ]
      params do
        optional :page, type: Integer, desc: 'page'
      end

      get do
        page = (params[:page] || 1).to_i
        get_heroes(page)
        if @heroes.present?
          render_success(@heroes['data'].as_json, pagination_dict_from_hash(@heroes))
        else
          render_success([].as_json)
        end
      end

      desc 'Get Hero', http_codes: [
        { code: 200, message: 'success' },
        { code: RESPONSE_CODE[:not_found], message: I18n.t('errors.not_found') }
      ]
      params do
        requires :id, type: String, desc: 'Hero id'
      end
      get ':id' do
        get_hero(params[:id])
        render_success(@hero.as_json)
      end

    end
  end
end
