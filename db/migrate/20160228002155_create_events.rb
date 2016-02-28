class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.date :time
      t.text :info

      t.timestamps null: false
    end
  end
end
