class AddStateToDomains < ActiveRecord::Migration[5.1]
  def change
    add_column :domains, :state, :integer, default: 0
  end
end
