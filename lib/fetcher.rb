class Fetcher
  # For debugging purposes when there is no internet.

  def initialize(debug=true)
    @debug = debug
  end

  def test_xml_file
    File.open(File.join(Rails.root, 'test', 'fixtures', 'XmlStatusReport.aspx'))
  end

  def xml_document(url)
    xml_file = @debug ? test_xml_file : Net::HTTP.get(URI.parse(url))
    REXML::Document.new(xml_file)
  end
#  doc = REXML::Document.new(xml)
#  doc.elements.each("Projects/Project") do |proj|

  def get_project_listing(url=nil)
    project_names = []
    xml_document(url).elements.each("Projects/Project") { |proj| project_names << proj.attributes["name"]}
    project_names
  end

  def update_project_status(project_id)
    project = Project.find(project_id)
    xml_document(project.feed_url).elements.each("Projects/Project") do |proj|
      attributes = proj.attributes
      build_label = attributes["lastBuildLabel"]

      if project.name == attributes["name"]
        puts "Project Name match: #{project.name} ==? #{attributes["name"]}"
        existing_build = project.builds.find_by_label(build_label)
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