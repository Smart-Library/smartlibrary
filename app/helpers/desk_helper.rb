module DeskHelper
  def desk_class(desk)
    desk.occupied? ? 'danger' : 'success'
  end

  def desk_status(desk)
    desk.occupied? ? 'Occupied' : 'Not Occupied'
  end

  def desk_element_id(desk)
    "desk_state_#{desk.id}"
  end
end
