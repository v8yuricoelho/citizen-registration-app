# frozen_string_literal: true

class CreateCitizens < ActiveRecord::Migration[7.0]
  def change
    create_table :citizens do |t|
      t.string :full_name, null: false
      t.string :cpf, null: false
      t.string :cns, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.date :birthdate, null: false
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
