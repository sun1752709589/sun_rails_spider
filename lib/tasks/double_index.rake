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
          elsif has_redundancy_index?(index_columns_inner['columns'],index_columns_outer['columns'])
            #冗余索引
            redundancy_index << "#{table}上存在冗余的索引:#{index_name_outer.to_s + get_index_columns_sorted(index_columns_outer['columns'],true)}&#{index_name_inner.to_s + get_index_columns_sorted(index_columns_inner['columns'],true)}"
          end
          handled_index << index_name_inner.to_s + index_name_outer.to_s
        end
      end
      handled_index = []
    end
    puts "*" * 20 + "重复索引" + "*" * 20
    double_index.each do |item|
      puts item
    end
    puts "*" * 20 + "冗余索引" + "*" * 20
    redundancy_index.each do |item|
      puts item
    end
    time_end = Time.new.to_i
    puts "-----------execute end----------Time:#{time_end-time_start}s------"
  end
  task :get_mysql_information_schema do
    Rake::Task[:environment].invoke
    puts "--------------catch articles start-------------------"
    time_start = Time.new.to_i
    # sql="show tables"
    # tables=ActiveRecord::Base.connection.execute(sql) # 得到当前数据库所有表
    sql = "select database()"
    database = ActiveRecord::Base.connection.execute(sql).first[0]

    sql="use information_schema"
    ActiveRecord::Base.connection.execute(sql)
    sql = "select TABLE_SCHEMA,TABLE_NAME,TABLE_TYPE,ENGINE,TABLE_ROWS,AVG_ROW_LENGTH,DATA_LENGTH,INDEX_LENGTH,(DATA_LENGTH+INDEX_LENGTH) as TABLE_LENGTH,AUTO_INCREMENT,CREATE_TIME,TABLE_COLLATION from information_schema.tables where table_schema = '#{database}'"
    tables = ActiveRecord::Base.connection.execute(sql)
    puts_line(12,10)
    head = ["数据库","表名","表类型","表引擎","表数据行数","平均行长度","数据大小","索引大小","总数据量","auto_increment","创建时间","字符集排序规则"]
    puts_line_arr(head,10)
    puts_line(12,10)

    tables.each do |item|
      item.each_with_index do |data,index|
        if [6,7,8].include?(index)
          item[index] = byte2mb(data)
        end
        if 10 == index
          item[index] = item[index].to_s[0..20]
        end
      end
      puts_line_arr(item,10)
    end
    puts_line(12,10)
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
  def has_redundancy_index?(columns1, columns2)
    columns1 = columns1.map do |item|
      if item.include?('(')
        item[0...item.index('(')]
      else
        item
      end
    end
    columns2 = columns2.map do |item|
      if item.include?('(')
        item[0...item.index('(')]
      else
        item
      end
    end
    if columns1.size > columns2.size
      columns1,columns2 = columns2,columns1
    end
    columns1.each_with_index do |item,index|
      return false if item != columns2[index]
    end
    return true
  end
  def byte2mb(byte)
    byte = byte.to_f
    if byte < 1024
      return "#{byte}Byte"
    elsif byte/1024 < 1024
      return "#{(byte/1024).round(2)}KB"
    elsif byte/(1024**2) < 1024
      return "#{(byte/(1024**2)).round(2)}MB"
    elsif byte/(1024**3) < 1024
      return "#{(byte/(1024**3)).round(2)}GB"
    elsif byte/(1024**4) < 1024
      return "#{(byte/(1024**4)).round(2)}TB"
    end
  end
  def puts_line(n,size)
    str = "+"
    (1..n).each do |i|
      str += "-"*size+"+"
    end
    puts str
  end
  def puts_line_arr(arr,size)
    str = "|"
    arr.each do |item|
      if size > item.size
        str += item.to_s + ' '*(size-item.size)+ "|"
      else
        str += item[0..size] + "|"[0..size]
      end
    end
    puts str
  end
end
