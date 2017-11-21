class DesksChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'desks'
  end
end
