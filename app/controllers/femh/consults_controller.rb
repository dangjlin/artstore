class Femh::ConsultsController < AdminController
    authorize_resource
    
    layout "femh"
    
    def index
   #  @consults = Consult.paginate(:page => params[:page], :per_page => 50).order("check_date1 DESC")
      @consults = Consult.order("check_date1 DESC")
     
    end
    
 
    
    def show
        
        @month_string = params[:id].to_s
        
        year = @month_string[0,4]
        month = @month_string[4,2]
        
        #@days = Time.days_in_month(@month_string.to_i,2015).to_s
        #@month_start = "2015-"+"#{@month_string}"+"-01" 
        #@month_end = "2015-"+"#{@month_string}"+"-"+"#{@days}"

        @days = Time.days_in_month(month.to_i,year).to_s
        @month_start = "#{year}-"+"#{month}"+"-01" 
        @month_end = "#{year}-"+"#{month}"+"-"+"#{@days}"


        
     @consult_all_month = Consult.where(check_date1: "#{@month_start}".."#{@month_end}").group("check_type").order("check_type").group("doc_name").order("sum_patient_no_only DESC").sum("patient_no_only")
     
     @consult_month_total_opened = Consult.where(check_date1: "#{@month_start}".."#{@month_end}").group(:check_type,:doc_name).count(:patient_no_only)
     
    end
    
end
