class ResourcesController < ApplicationController

  def index
    @resources = Resource.withoutDate()

    render json: @resources
  end

end