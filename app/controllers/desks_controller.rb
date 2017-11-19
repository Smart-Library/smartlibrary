class DesksController < ApplicationController
  before_action :load_desk, only: %i(show update)

  respond_to :html, only: %i(show)
  respond_to :json, only: %i(show create update)

  def index
    @desks = Desk.all
  end

  def create
    desk = Desk.new(desk_params)
    if desk.save
      respond_with(desk)
    else
      render_exception(desk)
    end
  end

  def show
    respond_with(@desk)
  end

  def update
    if @desk.update(desk_params)
      if broadcast_needed?
        ActionCable.server.broadcast('desks', @desk.slice('id', 'name', 'occupied'))
      end
      respond_with(@desk)
    else
      render_exception(@desk)
    end
  end

  private

  def load_desk
    @desk = Desk.find(params[:id])
  end

  def desk_params
    params.require(:desk).permit(:name, :occupied)
  end

  def broadcast_needed?
    !@desk.previous_changes.slice('name', 'occupied').empty?
  end
end
