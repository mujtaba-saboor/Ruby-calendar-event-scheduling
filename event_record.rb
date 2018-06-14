require 'date'
require_relative 'event_details'
class EventRecord
  @@events_date = Hash.new{|hash, key| hash[key] = []}
  @@events_details = {}
  @@id = 0

  def add_event_details(name, date)
    begin
      date = Date.parse(date,"%d-%b-%y")
      @@id += 1
      @@events_details[@@id] = Event_Details.new(@@id, name, date)
      year_month_key = "#{date.year.to_s}-#{date.month.to_s}"
      day = date.day
      @@events_date[year_month_key].push([name, day])
      puts "Event added"
      rescue
        puts "Incorrect Data"
    end
  end

  def self.return_date
    date = Date.parse(gets.strip,"%d-%b-%y")
  end

  def self.return_all_events
    if @@events_details.length == 0
      puts "No event added yet"
    else
      @@events_details.each do |key, event_detail|
        puts "ID: #{event_detail.id} Name: #{event_detail.event_name.ljust(7)} Date: #{event_detail.date.strftime("%Y/%m/%d")}"
    end
    end
  end
  
  def self.add_event
    EventRecord.new
  end
  
  def self.events_for_given_month
    if @@events_details.length == 0
      @@id = 0
      puts "No event added yet"
    else
      begin
        puts "Enter the required year (yyyy)"
        year = gets.strip.to_i
        puts "Enter the required month (mm)"
        month = gets.strip.to_i
        date = DateTime.new(year, month)
        year_month_key = "#{date.year.to_s}-#{date.month.to_s}"
        if [1, 3, 5, 7, 8, 10, 12].include?(date.month)
          range = (1..31)
        elsif [4, 6, 9, 11].include?(date.month)
          range = (1..30)
        elsif Date.leap?(date.year)
          range = (1..29)
        else
          range = (1..28)
        end
        month_event_detail_hash = Hash.new{|hash, key| hash[key] = []}
        if @@events_date.has_key? (year_month_key)
          @@events_date[year_month_key].each do |n|
            month_event_detail_hash[n[1].to_i] << n[0]
          end
        puts "Mon Tue Wed Thu Fri Sat Sun"
        dates = [nil] * 2 + (1..range.last).to_a
        dates.each_slice(7) do |week|
          puts week.map { |date|
          if month_event_detail_hash.has_key?(date)
            "["+date.to_s+"]"
           else
           date.to_s.rjust(3)
           end 
            }.join(' ')
        end
        puts
        month_event_detail_hash = month_event_detail_hash.sort.to_h
        month_event_detail_hash.each do |key, value|
          puts "#{key}: #{value} "
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
      @@id = 0
    else
      begin
        puts "Enter the required date (yyyy-mm-dd)"
        date = Date.parse(gets.strip)
        year_month_key = "#{date.year.to_s}-#{date.month.to_s}"
        month_event_detail_hash = Hash.new{ |hash, key| hash[key] = [] }
        if @@events_date.has_key? (year_month_key)
          @@events_date[year_month_key].each do |n|
            month_event_detail_hash[n[1].to_i] << n[0]
          end
          if month_event_detail_hash.has_key? (date.day)
            puts "Event(s) Scheduled: #{month_event_detail_hash[date.day]}"
          else
            puts "No Events Found"  
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
      @@id = 0
    else
      puts "Enter an Id from the list of events given below"
      self.return_all_events
      begin
        id_entered = gets.strip.to_i 
        if @@events_details.has_key?(id_entered)
          year = @@events_details[id_entered].date.year
          month = @@events_details[id_entered].date.month
          day = @@events_details[id_entered].date.day
          name = @@events_details[id_entered].event_name
          year_month_key = "#{year.to_s}-#{month.to_s}"
          @@events_date[year_month_key].each do |event_day| 
            if event_day[1] == day && event_day[0] == name 
              @@events_date[year_month_key].delete(event_day)
              @@events_details.delete(id_entered)
              puts "Event Deleted"
            end
          end
        else
          puts "Event not found"
        end
      rescue 
        puts "Incorrect data"
      end
    end
  end
end