class CreateProponents < ActiveRecord::Migration[7.1]
  def change
    create_table :proponents do |t|
      t.string :name, null: false
      t.string :document_br_cpf, limit: 11, null: false, index: { unique: true, name: 'proponents_cpf_unique' }
      t.date :birth_date, null: false
      t.string :address_public_place
      t.string :address_number
      t.string :address_district
      t.string :address_city
      t.string :address_state, limit: 2
      t.string :address_postalcode, limit: 8
      t.string :phone_contact, limit: 16
      t.string :phone_reference, limit: 16
      t.integer :salary_gross, null: false
      t.float :salary_social_contribution_aliquot
      t.integer :salary_social_contribution_value
      t.integer :salary_net

      t.timestamps
    end
  end
end
