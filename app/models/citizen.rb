# frozen_string_literal: true

class Citizen < ActiveRecord::Base
  has_one_attached :picture

  enum status: %i[inactive active]

  validates_presence_of :full_name, :email, :phone, :status
  validates_uniqueness_of :cpf, :cns, :email, :phone
  validates :cpf, cpf: true
  validates :cns, cns: true
  validates :birthdate, birthdate: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_one :address, dependent: :destroy

  accepts_nested_attributes_for :address

  def self.ransackable_attributes(_auth_object = nil)
    %w[birthdate cns cpf created_at email full_name id phone status
       updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[address picture_attachment picture_blob]
  end
end
