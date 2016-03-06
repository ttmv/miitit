class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :event_id
      t.text :msg
      t.datetime :timestamp

      t.timestamps null: false
    end
  end
end
