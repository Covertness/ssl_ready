class AddIndexToDomains < ActiveRecord::Migration[5.1]
  def change
    add_index :domains, :source_host, unique: true
  end
end
