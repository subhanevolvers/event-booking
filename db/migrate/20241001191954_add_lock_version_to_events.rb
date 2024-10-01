# frozen_string_literal: true

class AddLockVersionToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :lock_version, :integer, default: 0, null: false
  end
end
