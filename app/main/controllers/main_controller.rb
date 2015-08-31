# By default Volt generates this controller for your Main component
module Main
  class MainController < Volt::ModelController
    def index
      page._selected_date = Time.now.strftime('%F')
      page._selected_time = Time.now.strftime('%R')
      page._time_string_1 = '%R on %D'
      page._time_string_2 = '%l:%M%P %A, %B %-m, %Y'
      page._time_string_3 = 'Day %j, week %V of %Y'
      page._time_string_4 = '%s seconds past Unix Epoch'
      # Add code for when the index view is loaded
    end

    def display_time_as(format_string)
      time = Time.parse("#{page._selected_time} #{page._selected_date}")

      time.strftime(format_string)
    end

    private

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
