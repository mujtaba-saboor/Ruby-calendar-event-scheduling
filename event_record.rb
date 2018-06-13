class EventRecord
  @@events_date = {}
  @@events_name = []
  def add_event_details(name,date)
    begin
      date = date.split("-")
      key = date[0] + "-" + date[1]
      day = date[2]
      @@events_name << name
      if @@events_date.has_key? (key)
        @@events_date[key].push([name,day])
      else
        @@events_date[key] = Array.new
        @@events_date[key].push([name,day])
      end
      print "Event added\n"
      rescue
        puts "Incorrect Data"
    end
  end
  
  def self.return_all_events
    if @@events_name.length == 0
      puts "No event added yet"
    else
      @@events_name.each.with_index(1) do |n,idx|
        puts "#{idx}: #{n}"
    end
    end
  end
  
  def self.add_event
    EventRecord.new
  end
  
  def self.events_for_given_month
    if @@events_name.length == 0
      puts "No event added yet"
    else
      begin
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
        if @@events_date.has_key? (key)
          @@events_date[key].each do |n|
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
      rescue 
        puts "Incorrect Data"
      end
    end
  end
  
  def self.delete_event
    if @@events_name.length == 0
      puts "No event added yet"
    else
      begin
        print  "Enter name of the Event to delete \n"
        name = gets.chomp
        print  "Enter date of the Event to delete (yy:mm:dd)\n"
        date = gets.chomp
        date = date.split("-")
        year = date[0]
        month = date[1]
        day = date[2]
        flag = 0  
        key = year + "-" + month
        temp_array = @@events_date[key]
        for i in (0...temp_array.length)
          if temp_array[i][1] == day && temp_array[i][0] == name
            temp_array[i..i] = []
            @@events_name[@@events_name.index(name)..@@events_name.index(name)] = []
            @@events_date[key] = temp_array
            flag = 1
            puts "Event Deleted"
            break
          end
        end

        if flag == 0
          puts "Event not found"
        end
      rescue 
        puts "Incorrect data"
      end
    end
  end
end