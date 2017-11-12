class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def render_exception(resource)
    render json: resource.errors, status: :unprocessable_entity
  end
end
