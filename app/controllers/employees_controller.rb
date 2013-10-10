class EmployeesController < ApplicationController
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

  #show the list of employees
  def index
    @employees = Employee.all
  end
  
  #blank object to show the form to get the new employee
  def new
  #debugger
    @employee = Employee.new
    @employee.build_user 
  end
  #actually create the new employee
  def create
   #debugger
    #create the object of employee and assign the attributes in the request
    @employee = Employee.new(params[:employee])
    @employee.create_user(params[:employee][:user_attributes])
    #save the employee
    if @employee.save
      #User.create(name: @employee.user.name, email: @employee.user.email)
      #if saved, redirect to employee index page with success message
      return redirect_to employees_path(@employee), notice: "employee created successfuly"
    else
      #if saved, render the form with error messages
      return render action: "new"
    end    
  end
   
  def edit
    @employee = Employee.where(id: params[:id]).first
    #@employee.build_user
    if @employee.blank?
      return redirect_to employees_path, error: "Specified employee is not found"
    end
  end
  def update
  #debugger
    @employee = Employee.where(id: params[:id]).first
    if @employee.blank?
      return redirect_to employees_path, error: "Specified employee is not found"
    end
    if @employee.update_attributes(params[:employee])
      return redirect_to employees_path, notice: "employee updated successfully"
    else
      return render action: "edit"
    end
  end
  
  def destroy
    #find the employee from the Model: Employee where id of the employee is equal id in the params and assign it to variable “@employee”
    @employee = Employee.where(id: params[:id]).first
    if @employee.blank?
      return redirect_to employees_path, error: "Specified employee is not found"
    end
    #if @employee.projects is blank?
     
    if @employee.destroy
      return redirect_to employees_path, notice: "employee destroyed successfully"
    else
      return redirect_to employees_path, notice: "employee could not destroyed" 
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
  
  
  
