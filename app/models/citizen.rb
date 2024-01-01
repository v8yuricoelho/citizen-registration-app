# frozen_string_literal: true

class Citizen < ActiveRecord::Base
  has_one_attached :picture

  enum status: %i[inactive active]

  validates_presence_of :full_name, :email, :phone, :birthdate, :status
  validates_uniqueness_of :cpf, :cns, :email, :phone
  validates :cpf, cpf: true
  validates :cns, cns: true
  validates :birthdate, birthdate: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_one :address, dependent: :destroy

  accepts_nested_attributes_for :address
end
