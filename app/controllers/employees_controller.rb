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
    @employee = Employee.new
    #build user in employee object
    @employee.build_user
  end

  #actually create the new employee
  def create
    #create the object of employee and assign the attributes in the request
    @employee = Employee.new(params[:employee])
    @employee.build_user(params[:employee][:user_attributes])
    #save the employee
    if @employee.save
      #if saved, redirect to employee index page with success message
      return redirect_to employees_path, notice: "employee created successfuly"
    else
      #if saved, render the form with error messages
      return render action: "new"
    end
  end

  #edit the existing data
  def edit
    #find the employee from the Model: Employee where id of the employee is equal id in the params and assign it to variable “@employee”
    @employee = Employee.where(id: params[:id]).first
    #if @employee is blank
    if @employee.blank?
      #then redirect to employee index page with error message
      return redirect_to employees_path, error: "Specified employee is not found"
    end
  end
  
  #update the existing data
  def update
    #find the employee from the Model: Employee where id of the employee is equal id in the params and assign it to variable “@employee”
    @employee = Employee.where(id: params[:id]).first
    if @employee.blank?
    #if @employee is blank
      return redirect_to employees_path, error: "Specified employee is not found"
      #then redirect to employee index page with error message
    end
    #If the record is updated successfully except "email", then 
    if @employee.update_attributes(params[:employee].except("email"))
      #return and redirect to “employees index” page success message
      return redirect_to employees_path, notice: "employee updated successfully"
    #else  
    else
      #return and render the edit action of employee
      return render action: "edit"
    end
  end

  #destroy the employee and associated user
  def destroy
    #find the employee from the Model: Employee where id of the employee is equal id in the params and assign it to variable “@employee”
    @employee = Employee.where(id: params[:id]).first
    #@user = User.where(employee_id: params[:id]).first
    #if @employee is blank then
    if @employee.blank?
      #return and redirect to "employees index" page with error message 
      return redirect_to employees_path, error: "Specified employee is not found"
    end    
    #call the "destroy" method with object, if object is successfully deleted
    if @employee.destroy && @employee.user.destroy
      #redirect to "employees index" page with an success message
      return redirect_to employees_path, notice: "employee destroyed successfully"
    #else  
    else
      #redirect to "employees index" page with an success message
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
