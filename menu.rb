# menu
class Menu
  def self.menu_selection
    puts
    puts '1: To Add an event'
    puts '2: To View a specific month\'s event(s)'
    puts '3: To View a specific date\'s event(s)'
    puts '4: To View all events'
    puts '5: To Delete an event'
    puts '6: To Quit'
    line = gets.strip
  end
end
