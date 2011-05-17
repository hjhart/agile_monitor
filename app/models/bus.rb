class Bus < ActiveRecord::Base
  # TODO: Add active flag to buses
  # TODO: Add an "add" process for creating a bus with next_muni gem
  # TODO: Add bus_times to this model
  has_many :bus_times
end
