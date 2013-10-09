class ClientsController < ApplicationController
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

  #show the list of clients
  def index
    @clients = Client.all
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
      #if saved, redirect to client show page with success message
      return redirect_to client_path(@client), notice: "client created successfuly"
    else
      #if saved, render the form with error messages
      return render action: "new"
    end    
  end
  
  def show 
    #find the client from the Model: Client where id of the client is equal id in the params and assign it to variable “@client”
    @client = Client.where(id: params[:id]).first
    #if @client is blank
    if @client.blank?
      #redirect to client list page with an error message
      return redirect_to clients_path, error: "Specified client is not found"
    end
  end
  def edit
    @client = Client.where(id: params[:id]).first
    if @client.blank?
      return redirect_to clients_path, error: "Specified client is not found"
    end
  end
  
  def update
    @client = Client.where(id: params[:id]).first
    if @client.blank?
      return redirect_to clients_path, error: "Specified client is not found"
    end
    if @client.update_attributes(params[:client])
      return redirect_to client_path, notice: "client updated successfully"
    else
      return render action: "edit"
    end
  end
  
  def destroy
    #find the client from the Model: Client where id of the client is equal id in the params and assign it to variable “@client”
    @client = Client.where(id: params[:id]).first
    if @client.blank?
      return redirect_to clients_path, error: "Specified client is not found"
    end
    #if @client.projects is blank?
    if (@client.projects.blank?)
      if @client.destroy
        return redirect_to clients_path, notice: "client destroyed successfully"
      else
        return redirect_to clients_path, notice: "client could not destroyed" 
      end
    else
      #Redirect to “client list” page with the error message “Client could not destroyed ”
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
  
  
  
