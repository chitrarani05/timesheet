class Client < ActiveRecord::Base
  ############
  ## Requires
  ############
  #############
  ## Constants
  #############
  ################
  ## Associations
  ################
  has_many :projects
  has_many :tasksheet
  
  #######################
  ## Attribute Accessors
  #######################
  attr_accessible :name, :code

  ###############
  ## Validations
  ###############
  validates :name, presence: true, uniqueness: { case_sensitive: false} ,
    :format => { with: /^[a-zA-Z\s]*$/, message: "must be character and space" }
  validates :code, presence: true, uniqueness: { case_sensitive: false} ,
    :format => { with: /^[a-zA-Z0-9]*$/, message: "must be alphanumeric" }

  ##############
  ## Call Backs
  ##############
  before_validation :squish_fields

  #################
  ## Class Methods
  #################
  class << self
  end

  ######################
  ## Virtual Attributes
  ######################
  ######################
  ## Public Methods
  #####################
  def self.getclient
    arr = []
    obj = Client.all 
    obj.each do |client|
      #if client.projects.present?
        arr << client
      #end
    end
    arr    
  end    
  
  #####################
  ## Protected Methods
  #####################
  protected
  #####################
  ## Private Methods
  #####################
  private
    def squish_fields
      self.name = ((self.name.present?) ? self.name.squish : nil)
      self.code = ((self.code.present?) ? self.code.squish : nil)
    end

end  
