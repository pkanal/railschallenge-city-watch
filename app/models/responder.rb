class Responder < ActiveRecord::Base
  self.inheritance_column = nil
  validates :type, presence: true
  validates :name, presence: true, uniqueness: true
  validates :capacity, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 6 }

  RESPONDER_TYPES = %w(Fire Police Medical)

  scope :type_of_responder, ->(type) { where(type: type) }
  scope :on_duty, -> { where(on_duty: true) }
  scope :available, -> { where(emergency_code: nil) }
  scope :available_and_on_duty, -> { available.on_duty }

  def self.capacity_of(responders)
    responders.sum(:capacity)
  end

  def self.get_capacity_info_of(type)
    responders = type_of_responder(type)
    capacity_info = []
    capacity_info << capacity_of(responders)
    capacity_info << capacity_of(responders.on_duty)
    capacity_info << capacity_of(responders.available)
    capacity_info << capacity_of(responders.available_and_on_duty)
  end

  def self.show_city_capacity
    capacity = {}
    RESPONDER_TYPES.each do |type|
      capacity[type] = get_capacity_info_of(type)
    end
    capacity
  end
end
