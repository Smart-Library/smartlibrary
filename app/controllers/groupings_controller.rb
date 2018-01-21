class GroupingsController < ApplicationController
  before_action :load_grouping, only: %i(show edit update)

  def show
    @parent = @grouping.parent_grouping
    @grouping_name = @grouping.name
    @children = @grouping.children
    @background = @grouping.background.url
  end

  def edit
    @grouping_name = @grouping.name
    @children = @grouping.children
    @background = @grouping.background.url
  end

  def update
    return render_exception(@grouping) if params[:grouping] && !@grouping.update(grouping_params)
    if params[:layout]
      @grouping.children.each do |area|
        x, y = coordinate(area)
        if x && y
          if area.coordinate
            area.coordinate.x = x
            area.coordinate.y = y
            return render_exception(area.coordinate) unless area.coordinate.save
          else
            area.create_coordinate(x: x, y: y)
            return render_exception(area) unless area.save
          end
        end
      end
    end
    redirect_to edit_grouping_path
  end

  private

  def load_grouping
    @grouping = Grouping.find(params.require(:id))
  end

  def grouping_params
    params[:grouping].permit(:background, :parent_grouping_id, :name)
  end

  def coordinate(area)
    @lay_out ||= JSON.parse(params.require(:layout))
    @lay_out.dig(area.type, area.id.to_s)&.values_at('x', 'y') || [nil, nil]
  end
end
