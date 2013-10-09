class ProjectsController < ApplicationController
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

  #show the list of projects
  def index
    @projects = Project.all
  end
  
  #blank object to show the form to get the new project
  def new
    @project = Project.new
  end
  
  #actually create the new project
  def create
    #create the object of project and assign the attributes in the request
    @project = Project.new(params[:project])
    #save the project
    if @project.save
      #if saved, redirect to index method with success message
      redirect_to projects_path, notice: "project created successfuly"
    else
      #else, render the form with error messages
      render action: "new"
    end    
  end
  
  #edit the existing data  
  def edit
    #find the project from the Model: Project where id of the project is equal id in the params and assign it to variable “@project”
    @project = Project.where(id: params[:id]).first
    #if @project is blank 
    if @project.blank?
      #redirect to project list page with an error message
      return redirect_to projects_path, error: "Specified project is not found"
    end
  end
  
  #update the existing data
  def update
    #find the project from the Model: Project where id of the project is equal id in the params and assign it to variable “@project”
    @project = Project.where(id: params[:id]).first
    #if @project is blank 
    if @project.blank?
      #redirect to project list page with an error message
      return redirect_to projects_path, error: "Specified project is not found"
    end
    #if update is saved successfully
    if @project.update_attributes(params[:project])
      #redirect to project list page with an success message
      return redirect_to projects_path, notice: "project updated successfully"
    else
      #else, render the action "edit"
      return render action: "edit"
    end
  end
  
  #deleting the project from the project list
  def destroy
    #find the project from the Model: Project where id of the project is equal id in the params and assign it to variable “@project”
    @project = Project.where(id: params[:id]).first
    #if @project is blank
    if @project.blank?
      #redirect to project list page with an error message
      return redirect_to projects_path, error: "Specified project is not found"
    end
    #call the "destroy" method with object, if object is successfully deleted 
    if @project.destroy
      #redirect to project list page with an success message
      return redirect_to projects_path, notice: "project destroyed successfully"
    else
      #redirect to project list page with an error message
      return redirect_to projects_path, notice: "project could not destroyed" 
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
  
  
  
