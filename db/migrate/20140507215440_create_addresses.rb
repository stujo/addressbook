class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :address_type, default: 1
      t.string :street
      t.string :street_2
      t.string :city
      t.string :state
      t.string :zip
      t.references :contact, index: true

      t.timestamps
    end
  end
end
