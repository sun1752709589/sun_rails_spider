#encoding: utf-8
namespace :index do
  task :find_double_index do
    #重复索引：指在相同的列上按照相同的顺序创建的相同类型的索引
    #如果创建了索引（A，B），再创建索引（A）就是冗余索引。因为索引（A，B）也可以当作（A）来使用（只针对B-Tree）。
    #但是如果再创建索引（B，A）或者（B），则不是冗余索引。或者类型不同，比方说哈希，全文索引等。
    #冗余索引通常发生在添加索引的时候，大多数情况下都不需要冗余索引，而是尽量扩展已有的索引，
    #除非扩展已有的索引会导致索引很大，从而影响其他使用索引的性能。
    Rake::Task[:environment].invoke
    puts "--------------execute start-------------------"
    time_start = Time.new.to_i
    result = {}
    double_index = []
    redundancy_index = []
    sql="show tables"
    tables=ActiveRecord::Base.connection.execute(sql)
    tables.each do |item|
      next if item.first.include?('schema_migrations')
      tmp_hash = {}
      keys = ActiveRecord::Base.connection.execute("show index from #{item[0]}");
      keys.each do |item|
        tmp_hash["#{item[2]}"] = {} if tmp_hash["#{item[2]}"].nil?
        #tmp_hash["#{item[2]}"].merge!({non_unique: item[1]})
        item[4] += "(#{item[7]})" if !item[7].nil?
        if tmp_hash["#{item[2]}"]['columns'].nil?
          tmp_hash["#{item[2]}"]['columns'] = [item[4]]
        else
          tmp_hash["#{item[2]}"]['columns'] << item[4]
        end
        tmp_hash["#{item[2]}"]['index_type'] = item[10]
      end
      result.merge!({item[0] => tmp_hash})
    end
    result.each do |table,indexs|
      handled_index = []
      indexs.each do |index_name_outer,index_columns_outer|
        indexs.each do |index_name_inner,index_columns_inner|
          next if index_name_inner == index_name_outer || index_columns_inner['index_type'] != index_columns_outer['index_type'] || handled_index.include?(index_name_inner.to_s + index_name_outer.to_s) || handled_index.include?(index_name_outer.to_s + index_name_inner.to_s)
          #重复索引
          if get_index_columns_sorted(index_columns_inner['columns']) == get_index_columns_sorted(index_columns_outer['columns'])
            double_index << "#{table}上存在重复的索引:#{index_name_outer.to_s + get_index_columns_sorted(index_columns_outer['columns'],true)}&#{index_name_inner.to_s + get_index_columns_sorted(index_columns_inner['columns'],true)}"
          elsif get_index_columns_join(index_columns_inner['columns']).include?(get_index_columns_join(index_columns_outer['columns'])) || get_index_columns_join(index_columns_outer['columns']).include?(get_index_columns_join(index_columns_inner['columns']))
            #冗余索引
            redundancy_index << "#{table}上存在冗余的索引:#{index_name_outer.to_s + get_index_columns_sorted(index_columns_outer['columns'],true)}&#{index_name_inner.to_s + get_index_columns_sorted(index_columns_inner['columns'],true)}"
          end
          handled_index << index_name_inner.to_s + index_name_outer.to_s
        end
      end
      handled_index = []
    end
    puts "*" * 50
    puts double_index.inspect
    puts "*" * 50
    puts redundancy_index.inspect
    puts "*" * 50
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
  task :get_mysql_current_database do
    Rake::Task[:environment].invoke
    puts "--------------catch articles start-------------------"
    time_start = Time.new.to_i
    sql="select database()"
    tmp=ActiveRecord::Base.connection.execute(sql)
    tmp.each do |item|
      binding.pry
    end
    time_end = Time.new.to_i
    puts "-----------catch members end----------Time:#{time_end-time_start}s------"
  end
  def get_index_columns_sorted(columns, sub_part = false)
    if sub_part
      '(' + columns.join(',') + ')'
    else
      '(' + columns.map do |item|
        if item.include?('(')
          item[0...item.index('(')]
        else
          item
        end
       end.join(',') + ')'
    end
  end
  def get_index_columns_join(columns)
    columns.map do |item|
      if item.include?('(')
        item[0...item.index('(')]
      else
        item
      end
     end.join(',')
  end
end
