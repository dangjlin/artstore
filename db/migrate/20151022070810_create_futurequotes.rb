class CreateFuturequotes < ActiveRecord::Migration
  def change
    create_table :futurequotes do |t|
      t.date :check_date
      t.string :commodity_type
      t.float :open_price
      t.float :highest_price
      t.float :lowest_price_spot
      t.float :close_price_spot
      t.float :volume

      t.timestamps
    end
  end
end
