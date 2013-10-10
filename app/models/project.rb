class Project < ActiveRecord::Base
  ############
  ## Requires
  ############
  #############
  ## Constants
  #############
  ################
  ## Associations
  ################
  belongs_to :client

  #######################
  ## Attribute Accessors
  #######################
  attr_accessible :name, :code, :client_id

  ###############
  ## Validations
  ###############
  validates :name, presence: true,
    uniqueness: { scope: :client_id, case_sensitive: false,
                  message: "should be unique for per client" },
    format: { with: /^[a-zA-Z\s]*$/, message: "must be character and space" }

  validates :code, presence: true, uniqueness: { case_sensitive: false },
    format: { with: /^[a-zA-Z0-9]*$/, message: "must be alphanumeric" }

  validates :client_id, presence: true

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
