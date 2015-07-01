#encoding: utf-8
namespace :catch_company do
  task :catch_companys do
    Rake::Task[:environment].invoke
    puts "--------------catch companys start-------------------"
    time_start = Time.new.to_i
    agent = Mechanize.new
    code_entity = HTMLEntities.new
    (1..2).each do |i|
        url = "https://ruby-china.org/topics?page=#{i}"
      catch_51_companys(agent,url,code_entity)
      sleep 1
    end
    time_end = Time.new.to_i
    puts "-----------catch members end----------Time:#{time_end-time_start}s------"
  end
  def catch_51_companys(agent,url,code_entity)
    time_start = Time.new.to_i
    page = agent.get(url)
    html_doc = Nokogiri::HTML(page.body)
    arr = html_doc.xpath("//div[@class='tr0']")
    arr.each do |li|
      begin
        company_name = li.css(".//td[@class='td2'] a").first.text
        next if company_name.nil? || company_name.blank? || !Company.where(name: company_name).count.zero?
        # save company info
        company_url = li.css(".//td[@class='td2'] a").first['target']
        detail_page = agent.get(company_url)
        doc = Nokogiri::HTML(detail_page.body)
        
      rescue
         next
      end
    end
    time_end = Time.new.to_i
    puts "#{url[-10..-1]}----------------end---------Time:#{time_end-time_start}s----------"
  end
 
end