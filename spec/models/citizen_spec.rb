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

    it { is_expected.to validate_length_of(:cpf) }
    it { is_expected.to validate_length_of(:cns) }
  end
end
