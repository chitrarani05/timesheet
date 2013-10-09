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
