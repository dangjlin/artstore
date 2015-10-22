class Femh::ConsultsController < AdminController
    authorize_resource
    
    layout "femh"
    
    def index
     @consults = Consult.paginate(:page => params[:page], :per_page => 50).order("check_date1 DESC")
     
    end
    
    
    def show
        
        @month_string = params[:id].to_s
        @month_start = "2015-"+"#{@month_string}"+"-01" 
        @month_end = "2015-"+"#{@month_string}"+"-31"
        
     @consult_all_month = Consult.where(check_date1: "#{@month_start}".."#{@month_end}").group("check_type").order("check_type").group("doc_name").order("sum_patient_no_only DESC").sum("patient_no_only")
     
     @consult_month_total_opened = Consult.group(:check_type,:doc_name).count(:patient_no_only)
     
    end
    
end
