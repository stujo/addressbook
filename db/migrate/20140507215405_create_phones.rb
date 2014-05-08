class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.integer :phone_type, default: 1
      t.string :digits
      t.references :contact, index: true

      t.timestamps
    end
  end
end
