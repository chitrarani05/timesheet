class ReportsController < ApplicationController
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
    #if from date is present then
    if params[:from].present?
      #debugger
      #concate of year, month and day into single date 
      from = params[:from]["year"] +'/'+params[:from]["month"] +'/'+ params[:from]["day"]
      #concate of year, month and day into single date 
      to = params[:to]["year"] +'/'+params[:to]["month"] +'/'+ params[:to]["day"]
      #define a hash
      hash = {} 
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
        hash[:employee_id] = current_user.employee_id
        hash[:status] = params[:status]
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
      #find the record based on the hash attributes
      @record_froms = Tasksheet.where(hash).sort_by(&:date).sort_by(&:employee_id)
      #@record_froms.sort_by(&:date)
      #find the project based on the client id
      @projects  = Project.where(client_id: "#{params[:client]}").collect{ |u| [u.name, u.id] }
    end 
  end
   
  #show the project list based on the client 
  def project_for_client
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
 
  def edit
    #find the client from the Model: Client where id of the client is equal id in the params and assign it to variable “@client”
    @record = Tasksheet.where(id: params[:id]).first
    #if @client is blank
    if @record.blank?
      #return and redirect to clients list page with an error message
      return redirect_to reports_path, error: "Specified report is not found"
    end
  end
 
  #update the existing data
  def update
    #find the activity type from the Model: ActivityType where id of the activity type is equal id in the params and assign it to variable “@activity_type”
    @record = Tasksheet.where(id: params[:id]).first
    #if @activity_type is blank
    if @record.blank?
      #redirect to Activity Type list page with an error message
      return redirect_to reports_path, error: "Specified Record is not found"
    end
    #call skip_method variable by @record and put true in it
    @record.skip_method = true
    #concate of year, month and day into single date
    date = params[:date]["year"] +'/'+params[:date]["month"] +'/'+ params[:date]["day"]
    #concatenate of hour and minute into single time
    in_time = params[:in_time]["hour"] +':'+ params[:in_time]["minute"] 
    #concatenate of hour and minute into single time
    out_time = params[:out_time]["hour"] +':'+ params[:out_time]["minute"]
    #define a hash
    hash = {}
    #put the client into hash
    hash[:client_id] = params[:client]
    #put the project into hash  
    hash[:project_id] = params[:project]
    #put the activity_type into hash
    hash[:activity_type_id] = params[:activity_type]
    #put the task into hash 
    hash[:task] = params[:task]
    #put the date into hash 
    hash[:date] = date
    #put the in_time into hash 
    hash[:in_time] = in_time
    #put the out_time into hash 
    hash[:out_time] = out_time
    #put the remark into hash 
    hash[:remark] = params[:remark]
    #if update is saved successfully 
    if @record.update_attributes(hash)
      #redirect to "reports index" page with success message
      return redirect_to reports_path, notice: "Record updated successfully"
    #else  
    else
      #return and render the action "edit"
      return render action: "edit"
    end
  end
  
  def submit_for_approval 
    #debugger
    obj = params[:my_param].split
    hash = {}
    hash[:employee_id] = params[:ids]
    if obj.length > 1
      hash[:date] = (obj[0].to_date)..(obj[1].to_date)
    else
      hash[:date] = obj
    end 
    #debugger
    if params[:status] == "reject"
      hash[:status] = "reject"
    else 
      hash[:status] = "new" 
    end 
    #debugger  
    #hash[:employee_id] = current_user.employee_id  
    #date_arr = Array.class_eval(params[:my_param])
    
    #debugger
    #hash[:date] = (date_arr[0].to_date)..(date_arr[1].to_date)
    #hash[:
    #@task = Tasksheet.where(date: params[:my_param])
    Tasksheet.where(hash).update_all(status: "submit", reason: "")    
  end
  
  def all_submit
    if Tasksheet.where(employee_id: current_user.employee_id, status: "#{params[:status]}", date: ("#{params[:dates].first}".."#{params[:dates].last}")).update_all(status: "submit")
      redirect_to reports_path, notice: "Record has been submitted successfully"
    else
      redirect_to reports_path, notice: "Record not submitted"
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
