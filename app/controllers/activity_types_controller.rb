class ActivityTypesController < ApplicationController
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

  #show the list of Activity Type
  def index
    @activity_types = ActivityType.all
  end
  
  #blank object to show the form to get the new Activity Type
  def new
    @activity_type = ActivityType.new
  end
  
  #actually create the new Activity Type
  def create
    #create the object of Activity Type and assign the attributes in the request
    @activity_type = ActivityType.new(params[:activity_type])
    #save the activity_type
    if @activity_type.save
      #if saved, redirect to "Activity Type List" page with success message
      return redirect_to activity_types_path, notice: "Activity Type created successfuly"
    else
      #if saved, render the form with error messages
      return render action: "new"
    end    
  end
  
  #edit the existing data 
  def edit
    #find the activity type from the Model: ActivityType where id of the activity type is equal id in the params and assign it to variable “@activity_type”
    @activity_type = ActivityType.where(id: params[:id]).first
    #if @activity_type is blank 
    if @activity_type.blank?
      #redirect to Activity Type list page with an error message
      return redirect_to activity_types_path, error: "Specified Activity Type is not found"
    end
  end
  
  #update the existing data
  def update
    #find the activity type from the Model: ActivityType where id of the activity type is equal id in the params and assign it to variable “@activity_type”
    @activity_type = ActivityType.where(id: params[:id]).first
    #if @activity_type is blank
    if @activity_type.blank?
      #redirect to Activity Type list page with an error message
      return redirect_to activity_types_path, error: "Specified Activity Type is not found"
    end
    #if update is saved successfully
    if @activity_type.update_attributes(params[:activity_type])
      #redirect to Activity Type list page with success message
      return redirect_to activity_types_path, notice: "Activity Type updated successfully"
    else
      #else, render the action "edit"
      return render action: "edit"
    end
  end
  
  def destroy
    #find the activity_type from the Model: ActivityType where id of the activity type is equal id in the params and assign it to variable “@activity_type”
    @activity_type = ActivityType.where(id: params[:id]).first
    #if @activity_type is blank
    if @activity_type.blank?
      #redirect to Activity Type list page with an error message
      return redirect_to activity_types_path, error: "Specified Activity Type is not found"
    end
      #call the "destroy" method with object, if object is successfully deleted 
    if @activity_type.destroy
      #redirect to Activity Type list page with an success message
      return redirect_to activity_types_path, notice: "Activity Type destroyed successfully"
    else
      #redirect to Activity Type list page with an error message
      return redirect_to activity_types_path, notice: "Activity Type could not destroyed" 
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
  
  
  
