require 'date'
require_relative 'event_details'
class EventRecord
  @@events_date = {}
  @@events_details = {}
  @@id = 0
  def add_event_details(name,date)
    begin
      date = date.strip.split("-")
      date = DateTime.new(date[0].to_i, date[1].to_i, date[2].to_i)
      @@id += 1
      @@events_details[@@id] = Event_Details.new(@@id, name, date)
      key = date.year.to_s + "-" + date.month.to_s
      day = date.day
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
    if @@events_details.length == 0
      puts "No event added yet"
    else
      @@events_details.each.with_index(1) do |n,idx|
        puts "#{idx}:  #{n} "
    end
    end
  end
  
  def self.add_event
    EventRecord.new
  end
  
  def self.events_for_given_month
    if @@events_details.length == 0
      puts "No event added yet"
    else
      begin
        print "Enter the required year\n"
        year = gets.strip.to_i
        print "Enter the required month\n"
        month = gets.strip.to_i
        date = DateTime.new(year,month)
        key = date.year.to_s + "-" + date.month.to_s
        if [1,3,5,7,8,10,12].include?(date.month)
          range = (1..31)
        elsif [4,6,9,11].include?(date.month)
          range = (1..30)
        else
          range = (1..28)
        end
        tmp_hash = Hash.new{|h,k| h[k] = [] }
        if @@events_date.has_key? (key)
          @@events_date[key].each do |n|
            tmp_hash[n[1].to_i] << n[0]
          end
          tmp_hash = tmp_hash.sort.to_h
          c = 0
          range.each do |x|
            if tmp_hash.has_key? (x)
              print "#{x}: #{tmp_hash[x]} "
              c += 1
            else
              print "#{x} \t"
              c += 1
            end
            if c == 4
              c = 0
              puts 
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

   def self.events_for_given_date
    if @@events_details.length == 0
      puts "No event added yet"
    else
      begin
        print "Enter the required date\n"
        date = gets.strip.split("-")
        date = DateTime.new(date[0].to_i, date[1].to_i, date[2].to_i)
        key = date.year.to_s + "-" + date.month.to_s
        tmp_hash = Hash.new{|h,k| h[k] = [] }
        if @@events_date.has_key? (key)
          @@events_date[key].each do |n|
            tmp_hash[n[1].to_i] << n[0]
          end
          tmp_hash = tmp_hash.sort.to_h
          tmp_hash.each do |x|
            if tmp_hash.has_key? (date.day)
              print " Event(s) Scheduled: #{tmp_hash[date.day]} \t"
            else
              puts "No Events Found"  
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
    if @@events_details.length == 0
      puts "No event added yet"
    else
      print "Enter an Id from the list of events given below\n"
      self.return_all_events
      begin
        id_entered = gets.strip.to_i 
        year = @@events_details[id_entered].date.year
        month = @@events_details[id_entered].date.month
        day = @@events_details[id_entered].date.day
        name = @@events_details[id_entered].name
        key = year.to_s + "-" + month.to_s
        flag = 0  
        temp_array = @@events_date[key]
        for i in (0...temp_array.length)
          if temp_array[i][1] == day && temp_array[i][0] == name 
            temp_array[i..i] = []
            @@events_details.delete(id_entered)
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