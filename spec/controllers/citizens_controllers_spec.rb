# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CitizensController do
  let(:citizen) { create(:citizen) }
  let(:address) { create(:address, citizen_id: citizen.id) }
  let(:citizen_params) do
    {
      citizen: {
        full_name: Faker::Name.name_with_middle,
        cpf: Faker::IDNumber.unique.brazilian_citizen_number,
        cns: '201909244910007',
        email: Faker::Internet.unique.email(domain: 'gmail.com'),
        phone: Faker::PhoneNumber.unique.cell_phone,
        birthdate: Faker::Date.between(from: 110.years.ago, to: 2.years.ago),
        status: :active,
        picture: Rack::Test::UploadedFile.new(
          File.join(Rails.root, 'spec', 'fixtures', 'sample.jpg'), 'image/jpeg'
        ),
        address_attributes: {
          zip_code: Faker::Address.zip_code,
          street: Faker::Address.street_address,
          unit: Faker::Address.secondary_address,
          neighborhood: Faker::Address.community,
          city: Faker::Address.city,
          ibge_code: Faker::Number.number(digits: 7),
          uf: Address.ufs.keys.sample
        }
      }
    }
  end

  describe 'GET index' do
    it 'render citizen#index' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns @q with the Ransack search object' do
      get :index
      expect(assigns(:q)).to be_a Ransack::Search
    end
  end

  describe 'POST create' do
    context 'when params are valid' do
      it 'create citizen and redirect to citizen#show' do
        expect do
          post :create, params: citizen_params
        end.to change(Citizen, :count).by(1)

        expect(response).to redirect_to(Citizen.last)
      end
    end

    context 'when params are invalid' do
      it 'not create citizen redirect_to citizen#new' do
        citizen_params[:citizen][:cpf] = '12345678912'
        expect do
          post :create, params: citizen_params
        end.not_to change(Citizen, :count)

        expect(response).to redirect_to(new_citizen_path)
      end
    end
  end

  describe 'PATCH update' do
    let(:citizen) { create(:citizen) }

    context 'when params are valid' do
      it 'redirect to citizens#show' do
        patch :update, params: { id: citizen.id, citizen: citizen_params }

        expect(response).to redirect_to(citizen)
      end
    end

    context 'when params are invalid' do
      it 'not update citizen redirect_to citizen#edit' do
        citizen_params[:citizen][:cns] = '123456789123456'

        patch :update, params: citizen_params.merge(id: citizen.id)

        expect(citizen.full_name).not_to eq(citizen_params[:citizen][:full_name])
        expect(response).to redirect_to(edit_citizen_path(citizen))
      end
    end
  end
end
