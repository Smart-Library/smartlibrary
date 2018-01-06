class GroupingsController < ApplicationController
  before_action :load_grouping, only: %i(show)

  def show
    @parent = @grouping.parent_grouping
    @grouping_name = @grouping.name
    @children = @grouping.children
  end

  private

  def load_grouping
    @grouping = Grouping.find(params.require(:id))
  end
end
