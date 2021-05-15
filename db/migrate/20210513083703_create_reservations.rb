class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.references :user
      t.integer    :number_of_customer
      t.integer    :status,       null: false, default: 0
      t.text       :remark
      t.datetime   :booking_at
      t.integer    :table_number
      t.timestamps
    end
  end
end
