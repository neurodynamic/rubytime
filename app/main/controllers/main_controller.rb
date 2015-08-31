# By default Volt generates this controller for your Main component
module Main
  class MainController < Volt::ModelController
    def index
      page._selected_date = "#{Time.now.strftime('%Y')}-0#{(1..9).to_a.sample}-0#{(1..9).to_a.sample}"
      page._selected_time = "#{(13..23).to_a.sample}:#{(10..59).to_a.sample}"

      page._time_string_1 = '%l:%M%P %A, %B %-m, %Y'
      page._time_string_2 = '%Y, %C, %y'
      page._time_string_3 = '%B, %b, %m, %-m'
      page._time_string_4 = '%A, %a, %u, %w; %d, %-d'
      page._time_string_5 = '%H, %k, %I, %l:%M%P'
      # Add code for when the index view is loaded
    end

    def display_time_as(format_string)
      time = Time.parse("#{page._selected_time} #{page._selected_date}")

      time.strftime(format_string)
    end

    def set_random_time
      year = number_as_string_from(1900..Time.now.year)
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
