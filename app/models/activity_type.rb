class ActivityType < ActiveRecord::Base
  ############
  ## Requires
  ############
  #############
  ## Constants
  #############
  ################
  ## Associations
  ################
  has_many :tasksheet
  
  #######################
  ## Attribute Accessors
  #######################
  attr_accessible :name
  
  ###############
  ## Validations
  ###############
  validates :name, presence: true, uniqueness: {case_sensitive: false},
                   format: { with: /^[a-zA-Z\s]*$/, message: "must be character and space" }
                                                 
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
  def self.getactivity_type
    ActivityType.all
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
    end

end  
