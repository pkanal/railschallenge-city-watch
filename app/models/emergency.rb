class Emergency < ActiveRecord::Base
  validates :code, presence: true, uniqueness: true
  validates :police_severity,  presence: true,
                               numericality: {
                                 greater_than_or_equal_to: 0,
                                 message: 'must be greater than or equal to 0'
                               }
  validates :fire_severity,    presence: true,
                               numericality: {
                                 greater_than_or_equal_to: 0,
                                 message: 'must be greater than or equal to 0'
                               }
  validates :medical_severity, presence: true,
                               numericality: {
                                 greater_than_or_equal_to: 0,
                                 message: 'must be greater than or equal to 0'
                               }

end
