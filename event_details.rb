# event details
class EventDetails
  attr_accessor :event_name, :date, :id
  def initialize(id, event_name, date)
    @id = id
    @event_name = event_name
    @date = date
  end
end
