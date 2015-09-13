require 'opal/jquery'

# By default Volt generates this controller for your Main component
module Main
  class MainController < Volt::ModelController
    def index
      year = Time.now.strftime('%Y')
      month = number_as_string_from(1..9)
      day = number_as_string_from(1..9)
      hour = number_as_string_from(13..23)
      minute = number_as_string_from(0..59)

      page._selected_date = "#{year}-#{month}-#{day}"
      page._selected_time = "#{hour}:#{minute}"

      page._time_string = '%l:%M%P %A, %B %-m, %Y'

      Document.ready? do 
        `$('[data-toggle="tooltip"]').tooltip();`
      end
    end

    def display_time_as(format_string)
      year, month, day = page._selected_date.split('-')

      month_abbr = months[month.to_i-1]

      time_with_seconds = page._selected_time + ':00'

      time_string = "#{month_abbr} #{day} #{time_with_seconds} #{year}"
      
      time = Time.parse(time_string)
      time.strftime(format_string)
    end

    def months
      ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec']
    end

    def set_random_time
      year = number_as_string_from(1950..Time.now.year)
      month = number_as_string_from(1..12)
      day = number_as_string_from(1..28)
      hour = number_as_string_from(0..23)
      minute = number_as_string_from(0..59)

      page._selected_date = "#{year}-#{month}-#{day}"
      page._selected_time = "#{hour}:#{minute}"
    end

    def set_time_to_now
      page._selected_date = Time.now.strftime('%F')
      page._selected_time = Time.now.strftime('%R')
    end



    private

    def number_as_string_from(range)
      number = range.to_a.sample.to_s
      zero_pad(number)
    end

    def zero_pad(number_string)
      if number_string.length == 1
        "0" + number_string
      else
        number_string
      end
    end

    def string_format_codes
      {
        year: 
        [
          ['%Y','Year with century'],
          ['%y','Year % 100']
        ],

        month: 
        [
          ['%m','Month number, zero-padded'],
          ['%_m','Month number, blank-padded'],
          ['%-m','Month number, no-padded'],
          ['%B','Full month name'],
          ['%b','Abbreviated month name']
        ],

        week: 
        [
          ['%V','Week number of the week-based year (01..53)']
        ],

        day: 
        [
          ['%A','Day of the week name'],
          ['%a','Abbreviated day of the week name'],
          ['%u','Day of the week (Monday is 1, 1..7)'],
          ['%w','Day of the week (Sunday is 0, 0..6)'],
          ['%d','Day of the Month, zero-padded'],
          ['%-d','Day of the Month, no-padded'],
          ['%e','Day of the Month, blank-padded'],
          ['%j','Day of the Year, zero-padded']
        ],

        time: 
        [
          ['%H','Hour of the day, 24-hour clock, zero-padded'],
          ['%k','Hour of the day, 24-hour clock, blank-padded'],
          ['%I','Hour of the day, 12-hour clock, zero-padded'],
          ['%l','Hour of the day, 12-hour clock, blank-padded'],
          ['%P','AM or PM'],
          ['%p','am or pm'],
          ['%M','Minute of the hour, zero-padded'],
          ['%S','Second of the minute, zero-padded']
        ],

        other: 
        [
          ['%z','Time zone as hour and minute offset from UTC'],
          ['%Z','Time zone abbreviation name'],
          ['%s','Number of seconds since Unix Epoch']
        ],

        combo: 
        [
          ['%c','date and time (%a %b %e %T %Y)'],
          ['%D','Date (%m/%d/%y)'],
          ['%F','The ISO 8601 date format (%Y-%m-%d)'],
          ['%v','VMS date (%e-%b-%Y)'],
          ['%r','12-hour time (%I:%M:%S %p)'],
          ['%R','24-hour time (%H:%M)'],
          ['%T','24-hour time (%H:%M:%S)']
        ]
      }
    end

    # The main template contains a #template binding that shows another
    # template.  This is the path to that template.  It may change based
    # on the params._component, params._controller, and params._action values.
    def main_path
      "#{params._component || 'main'}/#{params._controller || 'main'}/#{params._action || 'index'}"
    end

    # Determine if the current nav component is the active one by looking
    # at the first part of the url against the href attribute.
    def active_tab?
      url.path.split('/')[1] == attrs.href.split('/')[1]
    end
  end
end
