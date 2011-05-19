class Bus < ActiveRecord::Base
  # TODO: Add an "add" process for creating a bus with next_muni gem
  has_many :bus_times
end
