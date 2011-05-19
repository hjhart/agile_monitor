class Fetcher
  # For debugging purposes when there is no internet.
  # url = '/Volumes/Macintosh HD/Users/jhart/workspace/agile_monitor/test/fixtures/XmlStatusReport.aspx'
  # doc = REXML::Document.new(File.open(url))


  def update_project_status(project_id)
    project = Project.find(project_id)
    url = 'http://rpx-ci.rpxcorp.local:3333/XmlStatusReport.aspx'
    xml = Net::HTTP.get(URI.parse(url))
    doc = REXML::Document.new(xml)
    doc.elements.each("Projects/Project") do |proj|
      attributes = proj.attributes
      build_label = attributes["lastBuildLabel"]

      if project.name == attributes["name"]
        puts "Project Name match: #{project.name} ==? #{attributes["name"]}"
        existing_build = Build.find_by_label(build_label)
        if existing_build
          puts "Build exists"
          if(existing_build.status != convert_activity(attributes["activity"]))
            puts "Updating attributes. Status has changed."
            existing_build.update_attributes({
              :status => convert_activity(attributes["activity"]),
              :last_build_status => attributes["lastBuildStatus"]
            })
          end
        else
          puts "Created build"
          Build.create({
            :project => project,
            :status => convert_activity(attributes["activity"]),
            :url => attributes["webUrl"],
            :build_time => attributes["lastBuildTime"],
            :last_build_status => attributes["lastBuildStatus"],
            :label => build_label
          })
        end
      end
    end
    nil
  end

  # Takes the status returned by CruiseControl.rb into enumerated stati
  def convert_activity(state)
    case state
    when 'CheckingModifications', 'Sleeping' then 'Idle'
    when 'Building' then 'Building'
    else 'Unknown'
    end
  end

  # Entering an array of times can be useful for pushing times without having to query the servers
  # This could be done every minute to decrement the minutes (not as accurate, but just as good)
  def update_bus_times(bus_id, times=nil)
    @bus = Bus.find(bus_id)

    if times.nil?
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