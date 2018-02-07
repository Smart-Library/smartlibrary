module ApplicationHelper
  def breadcrumb(area)
    content_tag :nav, class: 'breadcrumb' do
      hierarchy = area.hierarchy
      hierarchy.each_with_index.collect do |e, i|
        if i < hierarchy.size - 1
          link_to e.name, e, class: 'breadcrumb-item'
        else
          content_tag :span, e.name, class: 'breadcrumb-item active'
        end
      end.reduce(&:+)
    end
  end
end
