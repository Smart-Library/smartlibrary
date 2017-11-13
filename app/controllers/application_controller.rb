class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  def render_exception(resource)
    render json: resource.errors, status: :unprocessable_entity
  end
end
