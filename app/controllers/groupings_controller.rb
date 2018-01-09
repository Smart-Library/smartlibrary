class GroupingsController < ApplicationController
  before_action :load_grouping, only: %i(show edit update)

  def show
    @parent = @grouping.parent_grouping
    @grouping_name = @grouping.name
    @children = @grouping.children
  end

  def edit
    @grouping_name = @grouping.name
    @children = @grouping.children
  end

  def update
    lay_out = JSON.parse(params.require(:layout))
    @grouping.children.each do |area|
      x, y = lay_out[area.type][area.id.to_s].values_at('x', 'y')
      if area.coordinate
        area.coordinate.x = x
        area.coordinate.y = y
        render_exception(area.coordinate) unless area.coordinate.save
      else
        area.create_coordinate(x: x, y: y)
        render_exception(area) unless area.save
      end
    end
    redirect_to edit_grouping_path
  end

  private

  def load_grouping
    @grouping = Grouping.find(params.require(:id))
  end
end
