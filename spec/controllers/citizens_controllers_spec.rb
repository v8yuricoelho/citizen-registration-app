# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CitizensController do
  let(:citizen) { create(:citizen) }
  let(:citizen_params) do
    {
      full_name: Faker::Name.name_with_middle,
      cpf: Faker::IDNumber.unique.brazilian_citizen_number,
      cns: Faker::Number.unique.number(digits: 15),
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
      it 'render a success json' do
        post :create, params: citizen_params
        expect(response).to have_http_status :ok
      end
    end

    # context 'when CPF is invalid' do
    #   it 'render an error json' do
    #     post :create, params: citizen_params
    #     expect(response).to have_http_status '400'
    #   end
    # end

    # context 'when CNS is invalid' do
    # end

    # context 'when email is invalid' do
    # end
  end

  describe 'PATCH update' do
    context 'when params are valid' do
      it 'render a success json' do
        patch :update, params: citizen_params.merge(id: citizen.id)
        expect(response).to have_http_status :ok
      end
    end

    # context 'when CPF is invalid' do
    #   it 'render an error json' do
    #     post :create, params: citizen_params
    #     expect(response).to have_http_status '400'
    #   end
    # end

    # context 'when CNS is invalid' do
    # end

    # context 'when email is invalid' do
    # end
  end
end
