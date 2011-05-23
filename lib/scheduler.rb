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

    scheduler.every '30s' do
      Bus.find(:all, :conditions => {:active => true}).each do |bus|
        puts "Enqueueing for Bus #{bus.name}"
        Resque.enqueue(Fetcher, "Bus", bus.id)
      end
    end

    scheduler.join
  end
end