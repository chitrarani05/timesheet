class CheckReportsController < ApplicationController
  ###########
  ## Filters
  ###########
  ############
  ## Requires
  ############
  #############
  ## Constants
  #############
  ##################
  ## Public Actions
  ##################

  #show the reports based on the data in tasksheets
  def index
  #debugger
    if params[:from].present?
      #concate of year, month and day into single date 
      from = params[:from]["year"] +'/'+params[:from]["month"] +'/'+ params[:from]["day"]
      #concate of year, month and day into single date 
      to = params[:to]["year"] +'/'+params[:to]["month"] +'/'+ params[:to]["day"]
      #define a hash
      hash = {}
      if params[:employee].present?
        hash[:status] = params[:status]
        hash[:employee_id] = params[:employee]
      else 
        hash[:status] = params[:status]
      end     
      #check if client is present then
      if params[:client].present?
        #put the client into hash
        hash[:client_id] = params[:client]
      end 
      #check if project is present then 
      if params[:project].present?
        #put the project into hash  
        hash[:project_id] = params[:project]
      end 
      #check if activity_type is present then  
      if params[:activity_type].present?
        #put the activity_type into hash
        hash[:activity_type_id] = params[:activity_type]
      end
      #check if from date is present then 
      if params[:from].present?
        #hash[:employee_id] = current_user.employee_id
        #also check if from date is less than or equal to to date then
        if from.to_date <= to.to_date
          #put the from date to to date into hash
          hash[:date] = (from.to_date)..(to.to_date)
        #else check if from date is greater than to to date then  
        else from.to_date > to.to_date
          #put the to date to from date into hash
          hash[:date] = (to.to_date)..(from.to_date) 
        end 
      end 
      #debugger
      #find the record based on the hash attributes
      @employee_data = Tasksheet.where(hash).sort_by(&:date)
      #@record_froms.sort_by(&:date)
      #find the project based on the client id
      #debugger
      @projects  = Project.where(client_id: "#{params[:client]}").collect{ |u| [u.name, u.id] }
    end 
  end
  
  def project_for_client_admin
    #if params[:client] is blank string then
    if params[:client] != ""
      #find the project based on the client id
      @projects = Project.where(client_id: "#{params[:client]}").collect{ |u| [u.name, u.id] }
    #else  
    else
      #find all projects 
      @projects = Project.getproject.collect{ |u| [u.name, u.id] } 
    end  
  end
 
  #update the existing data
  def accept_data
    #debugger
    hash = {}
    hash[:date] = params[:my_param] 
    hash[:employee_id] = params[:ids]
    Tasksheet.where(hash).update_all(status: "accept")
  end
   
  def reject_data
    #debugger
    hash = {}
    hash[:date] = params[:my_param] 
    hash[:employee_id] = params[:ids]
    @reject = Tasksheet.where(hash)
    #if @accept.update_all(status: "reject")
    if @reject.update_all(status: "reject")
      #redirect_to check_reports_path, notice: "Record has been rejected"
    else
      #render action: "index"
    end
  end 
  
  def reason_for_rejection
    #debugger
    hash = {}
    hash[:date] = params[:my_param]
    hash[:employee_id] = params[:ids]
    Tasksheet.where(hash).update_all(reason: "#{params[:value]}")
  end 
  
  def accept_all_data
    if Tasksheet.where(employee_id: params[:ids].first..params[:ids].last, status: "submit").update_all(status: "accept")
      redirect_to check_reports_path, notice: "Record has been accepted successfully"
    else
      redirect_to check_reports_path, notice: "Record not accepted"
    end  
  end
  
  def reject_all_data
    if Tasksheet.where(employee_id: params[:ids].first..params[:ids].last, status: "submit").update_all(status: "reject")
      redirect_to new_check_report
    else
      redirect_to check_reports_path, notice: "Record not rejected"
    end  
  end
  
  def new 
    Tasksheet.where(employee_id: params[:ids].first..params[:ids].last, status: "submit").update_all(status: "reject")
  end 
  
  def create
    if Tasksheet.where(employee_id: params[:ids].first..params[:ids].last, status: "reject").update_all(reason: "#{params[:reason]}")
      redirect_to check_reports_path, notice: "Record has been rejected successfully"
    end
  end
   
  #####################
  ## Protected Methods
  #####################
  protected

  ###################
  ## Private Methods
  ###################
  private

end               
