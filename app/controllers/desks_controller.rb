class DesksController < ApplicationController
  before_action :load_desk, only: [:show, :update]

  def index
    @desks = Desk.all
  end

  def create
    desk = Desk.new(desk_params)
    if desk.save
      render json: desk
    else
      render_exception(desk)
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @desk }
    end
  end

  def update
    if @desk.update(desk_params)
      render json: @desk
    else
      render_exception(@desk)
    end
  end

  private

  def load_desk
    @desk = Desk.find(params[:id])
  end

  def desk_params
    params.require(:desk).permit(:id, :name, :occupied)
  end
end
