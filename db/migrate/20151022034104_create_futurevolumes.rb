class CreateFuturevolumes < ActiveRecord::Migration
  def change
    create_table :futurevolumes do |t|
      t.date :check_date
      t.string :commodity_type
      t.integer :foreign_unsettle_volume
      t.integer :total_unsettle_volume

      t.timestamps
    end
  end
end
