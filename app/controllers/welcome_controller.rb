class WelcomeController < ApplicationController
  def index
    @projects = Project.all(:conditions => {:active => true})
    @buses = Bus.all
  end
end
