class Project < ActiveRecord::Base
  #TODO: validates presence of properly formatted url
  #TODO: project last build, last builds
  #TODO: current status
  #TODO: Stati
  #It seems we're going to have to link all of the status to the blah blah. We can delete older than...
  validates_presence_of :name
  has_many :builds
end
