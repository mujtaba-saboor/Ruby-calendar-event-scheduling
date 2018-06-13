class Event_Details
  attr_accessor  :name, :date, :id
  def initialize (id, name, date)
    @id = id
    @name = name
    @date = date
  end
end