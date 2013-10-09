class ApplicationController < ActionController::Base
  ###########
  ## Filters
  ###########
  protect_from_forgery
  before_filter :authenticate_user!
  ############
  
  ## Requires
  ############
  ############
  ## Helpers
  ############
  #############
  ## Constants
  #############
  ##################
  ## Public Actions
  ##################
  #####################
  ## Protected Methods
  #####################
  protected
  ###################
  ## Private Methods
  ###################
  private
end
