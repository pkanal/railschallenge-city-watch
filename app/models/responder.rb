class Responder < ActiveRecord::Base
  self.inheritance_column = nil
  validates :type, presence: true
  validates :name, presence: true, uniqueness: true
  validates :capacity, presence: true, numericality: { greater_than_or_equal_to: 0, less_than: 6 }
end
