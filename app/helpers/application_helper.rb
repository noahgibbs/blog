# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title(str)
    @title = str
  end

  def time_to_human(time)
    duration = Time.now - time
    intervals = [ :year, :month, :week, :day, :hour, :minute ]
    intervals.each do |interval|
      if duration > 2.send(interval)
        return (duration / 1.send(interval)).to_i.to_s + " " +
          interval.to_s + "s"
      end
    end
    return duration.to_i.to_s + " seconds"
  end
end
