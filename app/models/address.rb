# frozen_string_literal: true

class Address < ActiveRecord::Base
  enum uf: %i[AC AL AP AM BA CE DF ES GO MA MT MS MG PA PB PR PE PI RJ RN RS RO RR SC SP SE TO]

  validates_presence_of :zip_code, :street, :neighborhood, :city, :uf

  belongs_to :citizen

  def self.ransackable_attributes(_auth_object = nil)
    %w[citizen_id city created_at ibge_code id neighborhood street uf unit
       updated_at zip_code]
  end
end
