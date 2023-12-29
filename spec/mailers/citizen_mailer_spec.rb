# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CitizenMailer do
  describe 'registration_notification' do
    let(:citizen) { create(:citizen) }
    let(:mail) { described_class.registration_notification(citizen.full_name, citizen.email) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Registo de munícipe')
      expect(mail.to).to eq([citizen.email])
      expect(mail.from).to eq(['no-reply@aws.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded.include?('Citizen Registration App')).to be(true)
      expect(mail.body.encoded.include?("Ola, #{citizen.full_name.split.first}!")).to be(true)
      expect(mail.body.encoded
      .include?('Seus dados foram cadastrados com sucesso na nossa aplicacao de registro de municipes.'))
        .to be(true)
    end
  end
end
