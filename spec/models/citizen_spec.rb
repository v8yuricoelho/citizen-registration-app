# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Citizen do
  subject { create(:citizen) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:full_name) }
    it { is_expected.to validate_presence_of(:cpf) }
    it { is_expected.to validate_presence_of(:cns) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_presence_of(:birthdate) }
    it { is_expected.to validate_presence_of(:status) }

    it { is_expected.to validate_uniqueness_of(:cpf).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:cns).case_insensitive }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_uniqueness_of(:phone).case_insensitive }

    describe 'when cpf is invalid' do
      let(:citizen) { subject }

      context 'when cpf size is less than 11' do
        it 'return an error' do
          citizen.cpf = '075442'
          expect(citizen.valid?).to be(false)
          expect(citizen.errors.full_messages).to eq(['Cpf is not valid'])
        end

        context 'when cpf is included in the deny list' do
          it 'return an error' do
            citizen.cpf = '00000000000'
            expect(citizen.valid?).to be(false)
            expect(citizen.errors.full_messages).to eq(['Cpf is not valid'])
          end
        end

        context 'when cpf does not match' do
          it 'return an error' do
            citizen.cpf = '12345678911'
            expect(citizen.valid?).to be(false)
            expect(citizen.errors.full_messages).to eq(['Cpf is not valid'])
          end
        end
      end
    end
  end
end
