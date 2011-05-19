class WelcomeController < ApplicationController
  #TODO: Handle it if there are no project builds.
  def index
    @projects = Project.all(:conditions => {:active => true})
    @buses = Bus.all(:conditions => {:active => true})
  end
end
