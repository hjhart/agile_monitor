class Project < ActiveRecord::Base
  #TODO: validates presence of properly formatted url
  validates_presence_of :name
end
