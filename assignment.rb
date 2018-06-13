require_relative "e_record.rb"
# require_relative "e_record_w_datetime.rb"
	
loop do 
	puts
	puts "For Adding an event, Enter: 1"
	puts "For Viewing a specific month's events, Enter: 2"
	puts "For Viewing all events, Enter: 3"
	puts "For Deleting an event, Enter: 4"
	puts "To Quit, Enter 5"
	line = gets.chomp
	e = []
	count = -1
	case line
	when "1"
		puts
	 	check = "y"
		while (check == "y")
			count += 1
			e << EventRecord.add_event	
			print "Enter name of the Event\n"
			name = gets.chomp
			print "Enter date for the event (yy:mm:dd)\n"
			date = gets.chomp
			e[count].add_event_details(name,date)
			print "Do u wish to add another event(y/n)?"
			check = gets.chomp
		end
	when "2"
		puts
		EventRecord.events_for_given_month	
	when "3"
		puts
		EventRecord.return_all_events
	when "4"
		puts
		EventRecord.delete_event
	when "5"
		puts
		p "Thank You"
		break
	else
		puts "Kindly choose the correct option"
	end
end