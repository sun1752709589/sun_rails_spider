module RedisClient
  module_function
  def config
    {:host=>'localhost', :port=>6379, :password=>'sun', :db => 0}
  end

  def client
    @redis||=Redis.new(config)
  end
end