class Employee < ActiveRecord::Base
  ############
  ## Requires
  ############
  #############
  ## Constants
  #############
  ################
  ## Associations
  ################
  has_one :user 
  
  ##############
  ## Call Backs
  ##############
  before_validation :squish_fields
  accepts_nested_attributes_for :user

  #######################
  ## Attribute Accessors
  #######################
  attr_accessible :firstname, :lastname, :code, :user_attributes

  ###############
  ## Validations
  ###############
  validates :firstname, presence: true, uniqueness: { case_sensitive: false} ,
                       format: { with: /^[a-zA-Z\s]*$/, message: "must be character and space" }

  validates :lastname, presence: true, uniqueness: { case_sensitive: false} ,
                       format: { with: /^[a-zA-Z\s]*$/, message: "must be character and space" }

  validates :code, presence: true, uniqueness: { case_sensitive: false} ,
                   format: { with: /^[a-zA-Z0-9]*$/, message: "must be alphanumeric" }

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
  def self.getemployee
    Employee.all
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
      self.firstname = ((self.firstname.present?) ? self.firstname.squish : nil)
      self.lastname = ((self.lastname.present?) ? self.lastname.squish : nil)
      self.code = ((self.code.present?) ? self.code.squish : nil)
    end

end  
