require 'active_record'

ActiveRecord::Base.logger = Logger.new(File.open('log/database.log', 'w'))
ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => 'db/development.sqlite3'
)


class Product < ActiveRecord::Base
    #lookup_data
=begin
    product = Product.new
    product.title = "Jo Malone3"
    product.description = "Perfume3"
    product.quantity = 30
    product.price = 9500
    product.save 
=end


end 

class Consult < ActiveRecord::Base

end

def write_data
    consult = Consult.new
    consult.title = "Jo Malone3"
    consult.description = "Perfume3"
    consult.quantity = 30
    consult.price = 9500
    consult.save 
end

write_data



