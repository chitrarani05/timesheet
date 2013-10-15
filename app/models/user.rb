class User < ActiveRecord::Base
  ############
  ## Requires
  ############
  #############
  ## Constants
  #############
  ##############
  ## Call Backs
  ##############
  before_validation :squish_fields

  ################
  ## Associations
  ################
  belongs_to :employee

  #######################
  ## Attribute Accessors
  #######################
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  # attr_accessible :title, :body
  attr_accessible :name, :login, :email, :password, :password_confirmation, :remember_me, :employee_id

  attr_accessor :login

  ###############
  ## Validations
  ###############

  validates :name,
            presence: true,
            uniqueness: {:case_sensitive => false},
            format: { with: /^[a-zA-Z\s]*$/, message: "must be character and space" }

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
  def password_required?
    super if confirmed?
  end

  def password_match?
    self.errors[:password] << "can't be blank" if password.blank?
    self.errors[:password_confirmation] << "can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "does not match password" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(name) = :value OR lower(email) = :value", { value: login.downcase }]).first
    else
      where(conditions).first
    end
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
