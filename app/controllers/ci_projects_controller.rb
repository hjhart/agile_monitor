class CiProjectsController < ApplicationController
  def get_names
    url = params[:url]
    @projects = Fetcher.new.get_project_listing(url)

    respond_to do |format|
      format.json  { render :json => @projects }
    end
  end
end
