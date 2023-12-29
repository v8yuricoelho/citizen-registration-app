# frozen_string_literal: true

class AddCitizenToAddress < ActiveRecord::Migration[7.0]
  def change
    add_reference :citizens, :address
  end
end
