class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :body
      t.datetime :deliver_in

      t.timestamps
    end
  end
end
