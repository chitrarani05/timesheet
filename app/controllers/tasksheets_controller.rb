class TasksheetsController < ApplicationController
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

  #show the tasksheet 
  def new
    @tasksheet = Tasksheet.new
  end
  
  #show the link to create a tasksheet
  def index
   
  end
  
  #show the project list based on the client
  def projects_for_client
    @tasksheet = Tasksheet.new
    @key = params[:id]
    #find the project based on the client id
    @projects = Project.where(client_id: "#{params[:client]["#{params[:id]}"]}").collect{ |u| [u.name, u.id] }
  end  
  
  #create a new row
  def create_row
    @tasksheet = Tasksheet.new
    @key = params[:key].to_i
  end
  
  #actually create the tasksheet with multiple rows
  def create
    #create an array
    @tasksheets = []
    #set k = 0
    k = 0
    #debugger
    params[:client].keys.each do |index|
      #concate of year, month and day into single date 
      date = params[:date][index]["year"] +'/'+params[:date][index]["month"] +'/'+ params[:date][index]["day"]
      #concatenate of hour and minute into single time
      in_time = params[:in_time][index]["hour"] +':'+ params[:in_time][index]["minute"] 
      #concatenate of hour and minute into single time
      out_time = params[:out_time][index]["hour"] +':'+ params[:out_time][index]["minute"]
      #create the object of tasksheet and assign the attributes in the request
      @tasksheets << Tasksheet.new(client_id: params[:client][index], project_id: params[:project][index], activity_type_id: params[:activity_type][index], task: params[:task][index], date: date, in_time: in_time, out_time: out_time, remark: params[:remark][index], employee_id: current_user.employee_id)   
    end 
    #debugger
    #set j = 0
    j = 0
    #set i = 0
    i = 0
    #if length of tasksheets is 1 then
    if @tasksheets.length == 1
      #check the object wether it is valid or not?
      if @tasksheets[0].valid?
        #if valid then set k = 1
        k = 1 
      end 
    #else     
    else
      #set k = 1
      k = 1
      #itrate the while loop from 0 to array of objects
      while i < (@tasksheets.length - 1)
        #next value of i in j
        j = i.next
        #check @tasksheets[0] is valid or not 
        if @tasksheets[0].valid?
          #if valid do nothing
        end
        #set l = 0
        l = 0
        #itrate the while loop
        while l <= i
          #set z = 0
          z = 0
          #check if date of current row is equal to previous row then
          if (@tasksheets[j].date == @tasksheets[l].date)
            #check if in_time of current row is greater or equal to in_time of previous row and out_time of current row is less or equal to out_time of previous row
            if ((@tasksheets[j].in_time.strftime("%H%M") >= @tasksheets[l].in_time.strftime("%H%M")) && (@tasksheets[j].out_time.strftime("%H%M") <= @tasksheets[l].out_time.strftime("%H%M")))
              #set z = 1
              z = 1
            #else check if in_time of current row is less than or equal to in_time of previous row and out_time of current row is greater than or equal to out_time of previous row    
            elsif((@tasksheets[j].in_time.strftime("%H%M") <= @tasksheets[l].in_time.strftime("%H%M")) && (@tasksheets[j].out_time.strftime("%H%M") >= @tasksheets[l].out_time.strftime("%H%M")))
              #set z = 1
              z = 1
            #else check if in_time of current row is less than to in_time of previous row and out_time of current row is less than to out_time of previous row and out_time of current row is greater than in_time of previous row  
            elsif((@tasksheets[j].in_time.strftime("%H%M") < @tasksheets[l].in_time.strftime("%H%M")) && ((@tasksheets[j].out_time.strftime("%H%M") < @tasksheets[l].out_time.strftime("%H%M")) && (@tasksheets[j].out_time.strftime("%H%M") > @tasksheets[l].in_time.strftime("%H%M"))))
              #set z = 1  
              z = 1
            #else check if in_time of current row is greater than to in_time of previous row and in_time of current row is less than to out_time of previous row and out_time of current row is greater than out_time of previous row  
            elsif(((@tasksheets[j].in_time.strftime("%H%M") > @tasksheets[l].in_time.strftime("%H%M")) && (@tasksheets[j].in_time.strftime("%H%M") < @tasksheets[l].out_time.strftime("%H%M"))) && (@tasksheets[j].out_time.strftime("%H%M") > @tasksheets[l].out_time.strftime("%H%M")))
              #set z = 1
              z = 1
            #else check the current row is valid or not  
            elsif @tasksheets[j].valid? 
              #if valid do nothing
            #else
            else
              #set k = 0 
              k = 0
            end
            #if z is equal to 1 then     
            if z == 1
              #check the current row is valid or not
              if @tasksheets[j].valid? 
                #if valid then add an error message
                @tasksheets[j].errors.add(:in_time, "already exists in the previous row") 
                #and set k = 0
                k = 0
              #else  
              else
                #add an error message to in_time of current row
                @tasksheets[j].errors.add(:in_time, "already exists in the previous row")
                #and set k = 0
                k = 0
              end 
            end 
          #else check the current row is valid or not        
          elsif @tasksheets[j].valid?
            #if valid do nothing
          #else
          else
            #set k = 0
            k = 0   
          end
          #increase the value of l by 1
          l += 1
        end
        #increase the value of i by 1
        i += 1
      end  
    end
    t = 0
    if Tasksheet.where(employee_id: @tasksheets.first.employee_id, date: @tasksheets.first.date..@tasksheets.last.date).present?
      if Tasksheet.where(employee_id: @tasksheets.first.employee_id, date: @tasksheets.first.date..@tasksheets.last.date, status: "new").present?
      
      else
        k = 0
        t = 1
      end
    end        
    #debugger  
    # if all objects in array is valid then
    if k == 1
    #if (@tasksheets.collect { |t| t.valid? }).all?
      #iterate the array of object 
      @tasksheets.each do |task| 
        #save each object
        task.save 
      end 
      #is data is saved then return and redirect to tasksheet index page with a success message 
      return redirect_to tasksheets_path, notice: 'Tasksheet was successfully created.'
    #else  
    else
      #if t == 1
      ###give the javascript alert her
        #respond_to do |format|
          #return format.js  
        #end
      #end
      #if not saved, render the new page
      return render action: "new"
    end  
  end
 
  #destroy the tasksheet
  def destroy
    #find the record from the Model: Tasksheet where id of the record is equal id in the params and assign it to variable “@record”
    @record = Tasksheet.where(id: params[:id]).first
    #if @record is blank
    if @record.blank?
      #redirect to reports index page with an error message
      return redirect_to reports_path, error: "Specified record is not found"
    end
    #call the "destroy" method with object, if object is successfully deleted 
    if @record.destroy
      #redirect to index page with an success message
      return redirect_to reports_path, notice: "record destroyed successfully"
    #else  
    else
      #return and redirect to index page with an success message
      return redirect_to reports_path, notice: "record could not destroyed" 
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
