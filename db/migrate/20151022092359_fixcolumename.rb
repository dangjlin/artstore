class Fixcolumename < ActiveRecord::Migration
  def change
    
    rename_column :futurequotes, :lowest_price_spot, :lowest_price
    rename_column :futurequotes, :close_price_spot, :close_price
    
  end
end
