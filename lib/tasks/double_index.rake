#encoding: utf-8
namespace :index do
  task :find_double_index do
    Rake::Task[:environment].invoke
    puts "--------------execute start-------------------"
    time_start = Time.new.to_i
    result = {}
    sql="show tables"
    tables=ActiveRecord::Base.connection.execute(sql)
    tables.each do |item|
      tmp_hash = {}
      keys = item[0].classify.constantize.connection.execute("show index from #{item[0]}");
      keys.each do |item|
        binding.pry
        tmp_hash["#{item[2]}"] = {} if tmp_hash["#{item[2]}"].nil?
        tmp_hash["#{item[2]}"].merge!({non_unique: item[1]})
        if tmp_hash["#{item[2]}"]['columns'].nil?
          tmp_hash["#{item[2]}"]['columns'] = [item[4]]
        else
          tmp_hash["#{item[2]}"]['columns'] << item[4]
        end


      end
    end
    puts tmp.first
    time_end = Time.new.to_i
    puts "-----------execute end----------Time:#{time_end-time_start}s------"
  end
  task :get_mysql_information_schema do
    Rake::Task[:environment].invoke
    puts "--------------catch articles start-------------------"
    time_start = Time.new.to_i
    sql="use information_schema"
    tmp=ActiveRecord::Base.connection.execute(sql)
    sql = "select data_length,index_length from tables where table_schema='spider' and table_name='companies'"
    tmp=ActiveRecord::Base.connection.execute(sql)
    tmp.each do |item|
      binding.pry
    end
    puts tmp.first
    time_end = Time.new.to_i
    puts "-----------catch members end----------Time:#{time_end-time_start}s------"
  end
end
