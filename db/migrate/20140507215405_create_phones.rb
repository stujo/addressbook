class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :phone_type
      t.string :digits
      t.references :contact, index: true

      t.timestamps
    end
  end
end
