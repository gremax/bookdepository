class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :zipcode, limit: 5
      t.string :city
      t.string :phone, limit: 12
      t.references :country, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
