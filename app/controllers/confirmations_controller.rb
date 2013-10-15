class ConfirmationsController < Devise::ConfirmationsController
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
  
  #show password after account confirmation
  def show
    #if confirmation token is present then find the confirmation token from the resource class and store into resource
    self.resource = resource_class.find_by_confirmation_token(params[:confirmation_token]) if params[:confirmation_token].present?
    #if current resource is nil or confirmed then call the super method
    super if resource.nil? or resource.confirmed?
  end

  #confirm account after setting the password
  def confirm
    #if  confirmation_token is present with the resource name then find confirmation token from the resource class and store it into resource 
    self.resource = resource_class.find_by_confirmation_token(params[resource_name][:confirmation_token]) if params[resource_name][:confirmation_token].present?
    #if all the attributes is updated except confirmation token with current resource object and password is matched then
    if resource.update_attributes(params[resource_name].except(:confirmation_token)) && resource.password_match?
      #call confirm_by_token with confirmation token from resource class and store into resource
      self.resource = resource_class.confirm_by_token(params[resource_name][:confirmation_token])
      #set flash message with notice and confirmed and
      set_flash_message :notice, :confirmed
      #redirect to the sign in page
      sign_in_and_redirect(resource_name, resource)
    #else  
    else
      #render the show action
      render :action => "show"
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

