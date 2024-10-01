# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.text :description
      t.string :location
      t.integer :available_tickets, default: 0
      t.datetime :schedule_at
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :events, :name, unique: true
  end
end
