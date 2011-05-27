require 'rufus/scheduler'

class Scheduler

  def initialize
    self.execute
  end

  def execute
    scheduler = Rufus::Scheduler.start_new

    scheduler.every '10s' do
      Project.find(:all, :conditions => {:active => true}).each do |project|
        puts "Enqueueing for project #{project.name}"
        Resque.enqueue(Fetcher, "Project", project.id)
      end
    end

    scheduler.every '5m' do
      if Time.now > Time.parse("3:00pm") && Time.now < Time.parse("5:00pm")
        Bus.find(:all, :conditions => {:active => true}).each do |bus|
          puts "Enqueueing for Bus #{bus.name}"
          Resque.enqueue(Fetcher, "Bus", bus.id)
        end
      else
      puts "Outside of 3pm to 7:35pm, not queuing bus getter."
      end
    end

    scheduler.every '30s' do
      if ( Time.now > Time.parse("5:00pm") && Time.now < Time.parse("7:30pm"))
        Bus.find(:all, :conditions => {:active => true}).each do |bus|
          puts "Enqueueing for Bus #{bus.name}"
          Resque.enqueue(Fetcher, "Bus", bus.id)
        end
      else
      puts "Outside of 3pm to 7:30pm, not queuing bus getter."
      end
    end

    scheduler.join
  end
end