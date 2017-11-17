class CreateDestinations < ActiveRecord::Migration[5.1]
  def change
    create_table :destinations do |t|
      t.string :messenger
      t.string :nickname
      t.belongs_to :message, foreing_key: true

      t.timestamps
    end
  end
end
