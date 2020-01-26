class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :subject
      t.text :body
      t.integer :event_type, index: true
      t.datetime :scheduled_date_at, index: true
      t.string :days, array: true, index: true
      t.integer :time_interval
      t.string :aasm_state, index: true
      t.references :user, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
