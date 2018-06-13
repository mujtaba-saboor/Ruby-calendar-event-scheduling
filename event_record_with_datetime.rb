require 'date'

class EventRecord
  @@events_date = {}
  @@events_name = []
  
  def add_event_details(name,data)
    tmp = data.split("-")
    tmp = DateTime.new(tmp[0].to_i,tmp[1].to_i,tmp[2].to_i)
    year = tmp.year.to_s
    month = tmp.month.to_s
    date = tmp.day.to_s
    @@events_name << name
    key = year + "-" + month
    if @@events_date.has_key? (key)
      @@events_date[key].push([name,date])
    else
      @@events_date[key] = Array.new
      @@events_date[key].push([name,date])
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
    end
  end
  
  def self.delete_event
    if @@events_name.length == 0
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
      temp = @@events_date[key]
      for i in (0...temp.length)
        if temp[i][1] == date
          temp[i..i] = []
          @@events_name[@@events_name.index(name)..@@events_name.index(name)] = []
          @@events_date[key] = temp
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