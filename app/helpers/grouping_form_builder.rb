class GroupingFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::FormTagHelper

  def grouping_select(method, **html_options)
    collection_select method, Grouping.all, :id, :name, { include_blank: '' }, html_options
  end
end
