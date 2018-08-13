class CreateDomains < ActiveRecord::Migration[5.1]
  def change
    create_table :domains do |t|
      t.string :source_host
      t.string :dest_host
      t.string :public_key
      t.string :private_key
      t.timestamp :renewal_date

      t.timestamps
    end
  end
end
