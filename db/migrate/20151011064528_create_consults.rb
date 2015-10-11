class CreateConsults < ActiveRecord::Migration
  def change
    create_table :consults do |t|
      t.date :check_date1
      t.string :check_date2
      t.string :check_type
      t.string :doc_name
      t.string :patient_no_string
      t.integer :patient_no_only
      t.string :time_slot
      t.string :room_no

      t.timestamps
    end
  end
end
