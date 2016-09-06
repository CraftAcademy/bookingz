module Api::ApiHelper

  def create_hour_range(parameters)
    start_time = parameters[:start_time] ? parameters[:start_time] : 0
    end_time = parameters[:end_time] ? parameters[:end_time] : 24.hours
    increment = parameters[:increment] ? parameters[:increment] : 30.minutes
    Array.new(1 + (end_time - start_time)/increment) do |i|
      [(Time.now.midnight + (i*increment) + start_time).strftime('%H:%M'),
       (Time.now.midnight + ((i + 1)*increment) + start_time).strftime('%H:%M')].join(' - ')
    end
  end
  # Usage: create_hour_range(start_time: 8.hours, end_time: 20.hours)


  def slot_booking(restaurant, date, slot)
    slot_start, slot_end, *tmp = slot.split(' - ')
    @booking = restaurant.current_day_bookings(date).detect do |booking|
      (DateTime.parse([date, slot_start].join(' '))..DateTime.parse([date, slot_end].join(' '))).cover?(booking.time_start.to_datetime)
    end
  end
end