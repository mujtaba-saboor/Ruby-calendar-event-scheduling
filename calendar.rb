# calendar
require 'date'
require_relative 'event_details'
class Calendar
  @events_details = Hash.new { |hash, key| hash[key] = [] }
  @id = 0

  def self.add_event
    check = 'y'
    while check == 'y'
      puts 'Enter name of the Event'
      name = gets.strip
      puts 'Enter date for the event (yyyy/mm/dd)'
      date = gets.strip
      date = Date.parse(date)
      @id += 1
      @events_details[date] << EventDetails.new(@id, name, date)
      puts 'Event added'
      puts 'Do you wish to add another event(y/n)?'
      check = gets.strip.downcase
    end
  rescue StandardError => e
    puts e.message
  end

  def self.return_all_events
    if !@events_details.empty?
      @events_details.each do |key, event_detail|
        event_detail.each do |event|
          puts "ID: #{event.id} Name: #{event.event_name.ljust(7)} Date: #{key.strftime('%Y/%m/%d')}"
        end
      end
    else
      puts 'No event added yet'
    end
  end

  def self.events_for_given_month
    if !@events_details.empty?
      puts 'Enter the required year and month (yyyy/mm)'
      date = Date.parse(gets.strip)
      firstday = date.wday
      lastday = Date.civil(date.year, date.month, -1).day
      month_event_detail_hash = {}
      puts 'Sun    Mon     Tue   Wed    Thu    Fri    Sat'
      dates = [nil] * firstday + (1..lastday).to_a
      dates.each_slice(7) do |week|
        puts week.map { |day|
               key = Date.new(date.year, date.month, day) unless day.nil?
               if @events_details.key? key
                 month_event_detail_hash[key] = @events_details[key]
                 "[#{'%02i' % day}]"
               elsif day.nil?
                 day.to_s.rjust(3).ljust(4)
               else
                 ('%02i' % day).to_s.rjust(3).ljust(4)
               end
             }.join('   ')
      end
      puts
      month_event_detail_hash = month_event_detail_hash.sort.to_h
      month_event_detail_hash.each do |key, event_detail|
        event_detail.each do |event|
          puts "ID: #{event.id} Name: #{event.event_name.ljust(7)} Date: #{key.strftime('%Y/%m/%d')}"
        end
      end
    else
      puts 'No event added yet'
    end
  rescue StandardError => e
    puts e.message
  end

  def self.events_for_given_date
    if !@events_details.empty?
      puts 'Enter the required date (yyyy/mm/dd)'
      date = Date.parse(gets.strip)
      if @events_details.key? date
        @events_details[date].each do |event|
          puts "ID: #{event.id} Name: #{event.event_name.ljust(7)} Date: #{event.date.strftime('%Y/%m/%d')}"
        end
      else
        puts 'No Events Found'
      end
    else
      puts 'No event added yet'
    end
  rescue StandardError => e
    puts e.message
  end

  def self.delete_event
    if !@events_details.empty?
      puts 'Enter an Id from the list of events given below'
      return_all_events
      flag = 0
      id_entered = gets.strip.to_i
      @events_details.each do |key, event_detail|
        event_detail.each do |event|
          if event.id == id_entered
            @events_details[key].delete(event)
            @events_details.delete(key) if @events_details[key].empty?
            puts 'Event Deleted'
            @id = 0 if @events_details.empty?
            flag = 1
            break
          end
        end
      end
      puts 'Event not found' if flag.zero?
    else
      puts 'No event added yet'
    end
  rescue StandardError => e
    puts e.message
  end
end
