class Emergency < ActiveRecord::Base
  has_many :responders
  serialize :responders, Array
  validates :code, presence: true, uniqueness: true
  validates :police_severity,  presence: true,
                               numericality: {
                                 greater_than_or_equal_to: 0
                               }
  validates :fire_severity,    presence: true,
                               numericality: {
                                 greater_than_or_equal_to: 0
                               }
  validates :medical_severity, presence: true,
                               numericality: {
                                 greater_than_or_equal_to: 0
                               }

  def self.assign_responders(type, amount, emergency)
    Responder.get_responders_for_dispatch(type, amount).each do |responder|
      responder.emergency_code = emergency.code
      emergency.responders << responder
      return true
    end
  end

  def self.dispatch_responders(emergency)
    assign_responders('Fire', emergency.fire_severity, emergency) if emergency.fire_severity > 0
    assign_responders('Police', emergency.police_severity, emergency) if emergency.police_severity > 0
    assign_responders('Medical', emergency.medical_severity, emergency) if emergency.medical_severity > 0
  end
end
