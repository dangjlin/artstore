class Femh::ConsultsController < ApplicationController
    
    layout "femh"
    
    def index
     @consults = Consult.order("id ASC")
    end
    
    
    def show
        
        @month_string = params[:id].to_s
        @month_start = "2015-"+"#{@month_string}"+"-01" 
        @month_end = "2015-"+"#{@month_string}"+"-31"
        
     @consult_all_month = Consult.where(check_date1: "#{@month_start}".."#{@month_end}").group("check_type").group("doc_name").sum("patient_no_only")
   end
    
end
