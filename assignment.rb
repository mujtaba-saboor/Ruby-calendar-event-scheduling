require_relative "event_record.rb"
event = {add: "1", month_view: "2", date_view: "3", all_events: "4", delete: "5", exit: "6"}  
loop do 
  puts
  puts "For Adding an event, Enter: 1"
  puts "For Viewing a specific month's event(s), Enter: 2"
  puts "For Viewing a specific date's event(s), Enter: 3"
  puts "For Viewing all events, Enter: 4"
  puts "For Deleting an event, Enter: 5"
  puts "To Quit, Enter 6"
  line = gets.chomp
  events = []
  count = -1
  case line
    when event[:add]
      puts
      check = "y"
      while (check == "y")
        count += 1
        events << EventRecord.add_event  
        print "Enter name of the Event\n"
        name = gets.chomp
        print "Enter date for the event (yy:mm:dd)\n"
        date = gets.chomp
        events[count].add_event_details(name,date)
        print "Do u wish to add another event(y/n)?"
        check = gets.chomp
      end
    when event[:month_view]
      puts
      EventRecord.events_for_given_month  
    when event[:date_view]
      puts
      EventRecord.events_for_given_date  
    when event[:all_events]
      puts
      EventRecord.return_all_events
    when event[:delete]
      puts
      EventRecord.delete_event
    when event[:exit]
      puts
      p "Thank You"
      break
    else
      puts "Kindly choose the correct option"
    end
end