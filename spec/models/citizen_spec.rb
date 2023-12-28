# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Citizen do
  subject { create(:citizen) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:full_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_presence_of(:birthdate) }
    it { is_expected.to validate_presence_of(:status) }

    it { is_expected.to validate_uniqueness_of(:cpf).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:cns).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_uniqueness_of(:phone).case_insensitive }

    context 'when email format is invalid' do
      let(:citizen) { subject }

      it 'return an error' do
        citizen.email = 'john_doe#.com'
        citizen.valid?
        expect(citizen.errors.full_messages).to eq(['Email is invalid'])
      end
    end

    describe 'when cpf is invalid' do
      let(:citizen) { subject }

      context 'when cpf size is less than 11' do
        it 'return an error' do
          citizen.cpf = '075442'
          citizen.valid?
          expect(citizen.errors.full_messages).to eq(['Cpf is not valid'])
        end

        context 'when cpf is included in the deny list' do
          it 'return an error' do
            citizen.cpf = '00000000000'
            citizen.valid?
            expect(citizen.errors.full_messages).to eq(['Cpf is not valid'])
          end
        end

        context 'when cpf does not match' do
          it 'return an error' do
            citizen.cpf = '12345678911'
            citizen.valid?
            expect(citizen.errors.full_messages).to eq(['Cpf is not valid'])
          end
        end
      end
    end

    describe 'when cns is invalid' do
      let(:citizen) { subject }

      context 'when cns size is less than 15' do
        it 'return an error' do
          citizen.cns = '185811852300'
          citizen.valid?
          expect(citizen.errors.full_messages).to eq(['Cns is not valid'])
        end
      end

      context 'when cns does not match' do
        it 'return an error' do
          citizen.cns = '123456789112345'
          citizen.valid?
          expect(citizen.errors.full_messages).to eq(['Cns is not valid'])
        end
      end
    end
  end
end
