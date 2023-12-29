# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CitizensController do
  let(:citizen) { create(:citizen) }
  let(:citizen_params) do
    {
      full_name: Faker::Name.name_with_middle,
      cpf: Faker::IDNumber.unique.brazilian_citizen_number,
      cns: '201909244910007',
      email: Faker::Internet.unique.email(domain: 'gmail.com'),
      phone: Faker::PhoneNumber.unique.cell_phone,
      birthdate: Faker::Date.between(from: 110.years.ago, to: 2.years.ago),
      status: :active
    }
  end

  describe 'GET index' do
    it 'render an index json' do
      get :index
      expect(response).to have_http_status :ok
    end
  end

  describe 'POST create' do
    context 'when params are valid' do
      it 'sends a registration notification email' do
      end

      it 'render a success json' do
        post :create, params: citizen_params
        expect(response).to have_http_status :ok
      end
    end

    context 'when params are invalid' do
      it 'render an error json' do
        citizen_params[:cpf] = '12345678911'
        post :create, params: citizen_params
        expect(response).to have_http_status :bad_request
      end
    end
  end

  describe 'PATCH update' do
    context 'when params are valid' do
      it 'sends a registration notification email' do
      end

      it 'render a success json' do
        patch :update, params: citizen_params.merge(id: citizen.id)
        expect(response).to have_http_status :ok
      end
    end

    context 'when params are invalid' do
      it 'render an error json' do
        citizen_params[:cns] = '123456789123456'
        patch :update, params: citizen_params.merge(id: citizen.id)
        expect(response).to have_http_status :bad_request
      end
    end
  end
end
