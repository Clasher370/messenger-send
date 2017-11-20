class AddStatusToDestinations < ActiveRecord::Migration[5.1]
  def change
    add_column :destinations, :status, :string
  end
end
