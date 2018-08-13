class CreateFluxes < ActiveRecord::Migration[5.1]
  def change
    create_table :fluxes do |t|
      t.integer :rx, limit: 8
      t.integer :tx, limit: 8
      t.references :domain, foreign_key: true

      t.timestamps
    end
  end
end
