class Tasksheet < ActiveRecord::Base
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
  belongs_to :project
  belongs_to :activity_type
  
  #######################
  ## Attribute Accessors
  ####################### 
  attr_accessible :client_id, :project_id, :activity_type_id, :task, :date, :in_time,
                       :out_time, :remark, :status, :employee_id
  attr_accessor :skip_method
  
  ###############
  ## Validations
  ###############
  validates_presence_of :client, message: "Please select a client!" 
  validates_presence_of :project, message: "Please select a project!"
  validates_presence_of :activity_type, message: "Please select a activity_type!"
  validates_presence_of :task, message: "Can not be blank!" 
  validate :must_be_less_or_equal_current_date,
       :must_be_less_or_equal_current_time, :intime_can_not_be_more_than_outtime, :should_be_in_range
  validate :should_not_be_db_data, unless: :skip_method
  
  ##############
  ## Call Backs
  ##############
  
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
    def must_be_less_or_equal_current_date
      if self.date > Date.today
        errors.add(:date, 'can not be more than current date')
      end
    end
 
    def must_be_less_or_equal_current_time
      if self.date == Date.today
        if self.in_time.strftime("%H:%M") > Time.now.strftime("%H:%M") 
          errors.add(:in_time, 'can not be more than current time')
        end
      end  
    end
    
    def intime_can_not_be_more_than_outtime
      if self.out_time <= self.in_time 
        errors.add(:out_time, 'must be greater than in_time')
      elsif self.date == Date.today
        if self.out_time.strftime("%H:%M") > Time.now.strftime("%H:%M") 
          errors.add(:out_time, 'can not be greater than current time') 
        end
      end
    end
    
    def should_not_be_db_data
      tasksheet = Tasksheet.where(date: self.date, employee_id: self.employee_id)
      z = 0
      if tasksheet.present?
        tasksheet.each do |task|
          if self.in_time <= task.in_time && self.out_time >= task.out_time
            z = 1
          elsif(self.in_time <= task.in_time && (self.out_time < task.out_time && self.out_time > task.in_time))
            z = 1
          elsif((self.in_time >= task.in_time && self.in_time < task.out_time) && self.out_time >= task.out_time)  
            z = 1
          elsif(self.in_time > task.in_time && self.out_time < task.out_time)
            z = 1
          end  
        end
        if z == 1
          errors.add(:in_time, "give the right time, this data is already in db")
        end
      end 
    end  
   
    def should_be_in_range
      @record = Tasksheet.where(id: self.id).first
      if @record.present?
        z = 0
        if((self.in_time.strftime("%H:%M") < @record.in_time.strftime("%H:%M")) && (self.out_time.strftime("%H:%M") <= @record.in_time.strftime("%H:%M")))
          z = 1
        elsif((self.in_time.strftime("%H:%M") >= @record.out_time.strftime("%H:%M")) && (self.out_time.strftime("%H:%M") > @record.out_time.strftime("%H:%M")))
          z = 1
        elsif((self.in_time.strftime("%H:%M") < @record.in_time.strftime("%H:%M")) && (self.out_time.strftime("%H:%M") >= @record.out_time.strftime("%H:%M"))) 
          z = 1
        elsif((self.in_time.strftime("%H:%M") == @record.in_time.strftime("%H:%M")) && (self.out_time.strftime("%H:%M") > @record.out_time.strftime("%H:%M"))) 
          z = 1
        elsif((self.in_time.strftime("%H:%M") < @record.in_time.strftime("%H:%M")) && (self.out_time.strftime("%H:%M") > @record.in_time.strftime("%H:%M")))
          z = 1
        elsif(((self.in_time.strftime("%H:%M") < @record.out_time.strftime("%H:%M")) && (self.in_time.strftime("%H:%M") < @record.in_time.strftime("%H:%M"))) && (self.out_time.strftime("%H:%M") >= @record.out_time.strftime("%H:%M")))
          z = 1
        end  
        if z == 1
          errors.add(:in_time, "must be #{@record.in_time.strftime("%H:%M")} to #{@record.out_time.strftime("%H:%M")} range ")
        end 
      end        
    end
  
end  
