class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :user,         null: false
      t.string     :order_number, null: false
      t.integer    :status,       null: false, default: 0
      t.datetime   :booking_at,   null: false
      t.text       :note
      t.timestamps
    end
  end
end
