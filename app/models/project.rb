class Project < ActiveRecord::Base
  #TODO: validates presence of properly formatted url
  #TODO: Add an "add" process from a particular feed.
    # User enters CCMenu feed.
    # Scan CCMenu feed. Parse the project names, display them in drop down.
    # User selects project name
    # User add project label (What it will show up on in their screen)
  validates_presence_of :name
  has_many :builds
end
