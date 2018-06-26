# main
require_relative 'calendar.rb'
require_relative 'menu.rb'
event = { add: '1', month_view: '2', date_view: '3',
          all_events: '4', delete: '5', exit: '6' }
loop do
  line = Menu.menu_selection
  case line
  when event[:add]
    Calendar.add_event
  when event[:month_view]
    Calendar.events_for_given_month
  when event[:date_view]
    Calendar.events_for_given_date
  when event[:all_events]
    Calendar.return_all_events
  when event[:delete]
    Calendar.delete_event
  when event[:exit]
    puts 'Thank You'
    break
  else
    puts 'Kindly choose the correct option'
  end
end
