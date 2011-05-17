class Fetcher
  def get_project_info(project_id)
    # TODO: Complete this function. Keep in mind there may be a gem to parse out CC feeds.
    @project = Project.find(project_id)
    url = @project.feed_url
    xml = Net::HTTP.get(URI.parse(url))
    doc = REXML::Document.new(xml)
    # No op from down here
    doc.elements.each('build status') do |build_status|
      # if (build_status.created_at IS not in our db)
      #   create it
      #   make sure to add to the status as appropriate
    end
  end

  # Entering an array of times can be useful for pushing times without having to query the servers
  # This could be done every minute to decrement the minutes (not as accurate, but just as good)
  def update_bus_times(bus_id, times=nil)
    @bus = Bus.find(bus_id)

    if times.empty?
      times = NextMuni.get_times(@bus.route_id.to_s, @bus.stop_id.to_s)
    end

    if times.present?
      @bus.bus_times.delete_all
      times.each do |bus_time|
        BusTime.create :bus => @bus, :minutes => bus_time
      end
    end
  end

end