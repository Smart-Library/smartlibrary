module ApplicationHelper
  def area_tag(area, *classes)
    x, y = area.coordinate&.slice(:x, :y)&.values_at(:x, :y) || [0, 0]
    classes.push('area', area.occupied? ? 'occupied' : 'free')
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
