class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :subject
      t.string :body
      t.string :event_type
      t.datetime :scheduled_date
      t.string :days, array: true
      t.integer :time_interval
      t.string :aasm_state
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
