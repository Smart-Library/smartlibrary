class Admin::LayoutsController < ApplicationController
  before_action :load_grouping, only: %i(edit update)

  def edit
    @grouping_name = @grouping.name
    @children = @grouping.children
  end

  def update
    lay_out = JSON.parse(params.require(:layout))
    @grouping.children.each do |area|
      x, y = lay_out[area.class.name.downcase][area.id.to_s].values_at('x', 'y')
      if area.coordinate
        area.coordinate.x = x
        area.coordinate.y = y
        render_exception(area.coordinate) unless area.coordinate.save
      else
        area.create_coordinate(x: x, y: y)
        render_exception(area) unless area.save
      end
    end
    redirect_to edit_admin_layout_path
  end

  private

  def load_grouping
    @grouping = Grouping.find(params.require(:id))
  end
end
