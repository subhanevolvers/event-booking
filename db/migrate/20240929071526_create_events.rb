class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
    t.string :name, null: false
    t.text :description
    t.string :location
    t.integer :available_tickets, default: 0
    t.datetime :schedule_at
    t.references :user, null: true, foreign_key: true

    t.timestamps
   end
  end
end
