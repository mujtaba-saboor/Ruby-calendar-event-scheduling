require 'date'

class EventRecord
	@@date_event = {}
	@@e_name=[]
	def add_event_details(name,data)
		tmp = data.split("-")
		var = DateTime.new(tmp[0].to_i,tmp[1].to_i,tmp[2].to_i)
		year = var.year.to_s
		month = var.month.to_s
		date = var.day.to_s
		@@e_name << name
		key = year + "-" + month
		if @@date_event.has_key? (key)
			@@date_event[key].push([name,date])
		else
			@@date_event[key] = Array.new
			@@date_event[key].push([name,date])
		end
	end
	
	def self.return_all_events
		if @@e_name.length == 0
			puts "No event added yet"
		else
			@@e_name.each.with_index(1) do |n,idx|
				puts "#{idx}: #{n}"
		end
		end
	end
	
	def self.add_event
		EventRecord.new
	end
	
	def self.events_for_given_month
		if @@e_name.length == 0
			puts "No event added yet"
		else
			print "Enter the required year\n"
			year = gets.chomp
			print "Enter the required month\n"
			month = gets.chomp
			if [1,3,5,7,8,10,12].include?(month.to_i)
				range = (1..31)
			elsif [4,6,9,11].include?(month.to_i)
				range = (1..30)
			else
				range = (1..28)
			end
			tmp_hash = Hash.new{|h,k| h[k] = [] }
			key = year + "-" + month
			if @@date_event.has_key? (key)
				@@date_event[key].each do |n|
					tmp_hash[n[1].to_i] << n[0]
				end
				tmp_hash = tmp_hash.sort.to_h
				range.each do |x|
					if tmp_hash.has_key? (x)
						print "Date #{x}: Event Scheduled: #{tmp_hash[x]}\n"
					else
						print "Date #{x}: \n"
					end
				end
			else
				puts "No Events Found"
			end
		end
	end
	
	def self.delete_event
		if @@e_name.length == 0
			puts "No event added yet"
		else
			print  "Enter name of the Event to delete \n"
			name = gets.chomp
			print  "Enter date of the Event to delete (yy:mm:dd)\n"
			date = gets.chomp
			t = date.split("-")
			year = t[0]
			month = t[1]
			date=t[2]
			flag = 0
			key = year + "-" + month	
			temp = @@date_event[key]
			for i in (0...temp.length)
				if temp[i][1] == date
					temp[i..i]=[]
					@@e_name[@@e_name.index(name)..@@e_name.index(name)]=[]
					@@date_event[key] = temp
					flag = 1
					puts "Event Deleted"
					break
				end
			end

			if flag == 0
				puts "Event not found"
			end
		end
	end
end