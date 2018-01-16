module GroupingHelper
  def area_tag(area, *classes)
    x, y = area.coordinate&.slice(:x, :y)&.values_at(:x, :y) || [0, 0]
    classes.push('area', area.occupied? ? 'occupied' : 'free')
    if area.kind_of?(Desk)
      classes.push('desk')
    elsif area.kind_of?(Grouping)
      classes.push('grouping')
    end
    content_tag(:div,
                nil,
                title: area.name,
                :'data-type' => area.type,
                :'data-id' => area.id,
                :'data-toggle'=> 'tooltip',
                class: classes,
                :'data-x' => x,
                :'data-y' => y,
                style: "transform: translate(#{x}px, #{y}px)")
  end
end
