# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address do
  describe 'validations' do
    subject { create(:address) }

    describe 'validations' do
      it { is_expected.to validate_presence_of(:zip_code) }
      it { is_expected.to validate_presence_of(:street) }
      it { is_expected.to validate_presence_of(:neighborhood) }
      it { is_expected.to validate_presence_of(:city) }
      it { is_expected.to validate_presence_of(:uf) }
    end
  end
end
