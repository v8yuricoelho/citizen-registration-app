# frozen_string_literal: true

class Citizen < ActiveRecord::Base
  enum status: %i[inactive active]

  validates_presence_of :full_name, :cpf, :cns, :email, :phone, :birthdate, :status
  validates_uniqueness_of :cpf, :cns, :email, :phone
  validates :cpf, cpf: true
end
