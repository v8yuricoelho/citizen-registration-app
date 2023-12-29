# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :zip_code, null: false
      t.string :street, null: false
      t.string :unit
      t.string :neighborhood, null: false
      t.string :city, null: false
      t.string :ibge_code
      t.integer :uf, null: false

      t.timestamps
    end
  end
end
