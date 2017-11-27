module DeskHelper

  def desk_class(desk)
    return 'danger' if desk.occupied?
    'success'
  end

  def desk_status(desk)
    return 'Occupied' if desk.occupied?
    'Not Occupied'
  end

end