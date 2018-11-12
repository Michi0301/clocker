# frozen_string_literal: true

class CreateClockEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name

      t.timestamps
    end

    add_index :users, :name, unique: true

    create_table :clock_events do |t|
      t.string :event_type, null: false
      t.belongs_to :user

      t.timestamps
    end
  end
end
