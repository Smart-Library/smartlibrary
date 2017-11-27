module DeskHelper

  def desk_class(desk)
    return 'danger' if desk.occupied?
    'success'
  end

  def desk_status(desk)
    return 'Occupied' if desk.occupied?
    'Not Occupied'
  end

  def desk_element_id(desk)
    "desk_state_#{desk.id}"
  end
end