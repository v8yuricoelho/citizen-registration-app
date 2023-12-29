require "rails_helper"

RSpec.describe CitizenMailer, type: :mailer do
  describe "registration_notification" do
    let(:citizen) { create(:citizen) }
    let(:mail) { CitizenMailer.registration_notification(citizen.full_name, citizen.email) }

    it "renders the headers" do
      expect(mail.subject).to eq("Registo de munícipe")
      expect(mail.to).to eq([citizen.email])
      expect(mail.from).to eq(["no-reply@aws.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include("Citizen Registration App")
      expect(mail.body.encoded).to include("Ola, #{citizen.full_name.split.first}!")
      expect(mail.body.encoded).to include("Seus dados foram cadastrados com sucesso na nossa aplicacao de registro de municipes.")
    end
  end

end
