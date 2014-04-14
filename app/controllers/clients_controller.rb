class ClientsController < ApplicationController
  ###########
  ## Filters
  ###########
  ############
  ## Requires
  ############
  require 'will_paginate/array'
  
  #############
  ## Constants
  #############
  ##################
  ## Public Actions
  ##################

  #show the list of clients
  def index
    @clients = Client.all.paginate(page: params[:page], per_page: 4)
  end

  #blank object to show the form to get the new client
  def new
    @client = Client.new
  end

  #actually create the new client
  def create
    #create the object of client and assign the attributes in the request
    @client = Client.new(params[:client])
    
    #save the client
    if @client.save
      #if saved, return and redirect to client show page with success message
      return redirect_to client_path(@client), notice: "client created successfuly"
    else
      #if not saved, render the form with error messages
      return render action: :new
    end
  end

  def show
    #find the client from the Model: Client where id of the client is equal id in the params and assign it to variable “@client”
    @client = Client.where(id: params[:id]).first
    #if @client is blank
    if @client.blank?
      #return and redirect to clients list page with an error message
      return redirect_to clients_path, error: "Specified client is not found"
    end
  end
  
  #edit the client
  def edit
    #find the client from the Model: Client where id of the client is equal id in the params and assign it to variable “@client”
    @client = Client.where(id: params[:id]).first
    #if @client is blank
    if @client.blank?
      #return and redirect to clients list page with an error message
      return redirect_to clients_path, error: "Specified client is not found"
    end
  end
  
  #update the client
  def update
    #find the client from the Model: Client where id of the client is equal id in the params and assign it to variable “@client”
    @client = Client.where(id: params[:id]).first
    #if @client is blank
    if @client.blank?
      #return and redirect to clients list page with an error message
      return redirect_to clients_path, error: "Specified client is not found"
    end
    #if update is saved successfully
    if @client.update_attributes(params[:client])
      #redirect to "client show" page with success message
      return redirect_to client_path, notice: "client updated successfully"
    #else  
    else
      #return and render the edit page
      return render action: "edit"
    end
  end

  #destroy the client
  def destroy
    #find the client from the Model: Client where id of the client is equal id in the params and assign it to variable “@client”
    @client = Client.where(id: params[:id]).first
    #if @client is blank
    if @client.blank?
      #return and redirect to clients list page with an error message
      return redirect_to clients_path, error: "Specified client is not found"
    end
    #if @client.projects is blank?
    if (@client.projects.blank?)
      #call the "destroy" method with object, if object is successfully deleted 
      if @client.destroy
        #redirect to "clients index" page with an success message
        return redirect_to clients_path, notice: "client destroyed successfully"
      #else  
      else
        #redirect to "clients index" page with an success message
        return redirect_to clients_path, notice: "client could not destroyed"
      end
    else
      #Redirect to “clients list” page with the error message “Client could not destroyed ”
      return redirect_to clients_path, notice: "client could not destroyed"
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
