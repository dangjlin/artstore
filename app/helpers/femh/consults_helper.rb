module Femh::ConsultsHelper
    
    def render_count_open_total(input)
    
    @count_open = @consult_month_total_opened.fetch(input[0])
    
    end
    
    def render_count_average_patient(input)
        
   number_with_precision((input[1].to_f/@count_open).to_f, precision: 2)
    
    end 

end
