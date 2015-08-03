class HardWorker
  include Sidekiq::Worker
  def perform(name, count)
    puts "~" * 50
    puts name
    puts count
    puts "~" * 50
  end
end