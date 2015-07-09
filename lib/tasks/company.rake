#encoding: utf-8
require 'open-uri'
require 'logger'
namespace :catch_company do
  task :catch_companys do
    Rake::Task[:environment].invoke
    puts "--------------catch companys start-------------------"
    time_start = Time.new.to_i
    agent = Mechanize.new
    code_entity = HTMLEntities.new
    (607..700).each do |i|
        url = "http://search.51job.com/jobsearch/search_result.php?keyword=java&curr_page=#{i}"
      catch_51_companys(agent,url,code_entity)
      sleep 1
    end
    time_end = Time.new.to_i
    puts "-----------catch members end----------Time:#{time_end-time_start}s------"
  end
  def catch_51_companys(agent,url,code_entity)
    time_start = Time.new.to_i
    page = agent.get(url)
    #page.body = page.body.force_encoding("gbk").encode("UTF-8")
    #agent.page.encoding = 'gb2312'
    html_doc = Nokogiri::HTML(page.body.force_encoding("gbk").encode("UTF-8"))
    arr = html_doc.xpath("//tr[@class='tr0']")
    arr.each do |li|
      begin
        company_name = li.css("td[@class='td2'] a").first.text
        next if company_name.nil? || company_name.blank?
        # save company info
        company_url = li.css("td[@class='td2'] a").first['href']
        detail_page = agent.get(company_url)
        doc = Nokogiri::HTML(detail_page.body.force_encoding("gbk").encode("UTF-8"))
        next if doc.css("//p[@class='txt_font1']").size.zero?
        company_name = doc.css("td[@class='sr_bt']").first.text.split('        ')[0]
        next if !Company.where(name: company_name).count.zero?
        #binding.pry
        basic_info_doc = doc.css("div").css("table[@class='jobs_1']").css("tr").last
        basic_info_arr = basic_info_doc.text.split('：')
        basic_info = basic_info_arr
        company_industry = basic_info_arr[1][0...basic_info_arr[1].index("公司性质")].strip
        company_nature = basic_info_arr[2][0...basic_info_arr[2].index("公司规模")].strip
        company_scale = basic_info_arr[3].strip
        company_industry_id = Industry.find_or_create_by(name: company_industry).id
        company_nature_id = Nature.find_or_create_by(name: company_nature).id
        company_scale_id = Scale.find_or_create_by(name: company_scale).id
        
        company_desc = code_entity.encode(doc.xpath("//p[@class='txt_font']").first.to_html)
        
        detail_info = doc.css("//p[@class='txt_font1']")
        company_website = detail_info[0].text.split('：')[-1]
        company_address = detail_info[1].text.split('：')[-1].split(' ')[0]
        company_zip_code = detail_info[2].text.split('：')[-1]
        company = Company.create({name: company_name, detail_info_url: company_url, industry_id: company_industry_id, nature_id: company_nature_id,
                                  scale_id: company_scale_id, detail_introduce: company_desc,website: company_website,
                                  address: company_address, zip_code: company_zip_code
        })
        if company.save
          tag_url = li.css("td[@class='td1'] a").first['href']
          tag_page = agent.get(tag_url)
          doc = Nokogiri::HTML(tag_page.body)
          next if doc.css("//div[@class='jobdetail_divRight_span']").size.zero?
          tag_arr = doc.css("span[@class='Welfare_label']")
          if tag_arr.size > 0
            tag_arr.each do |item|
              tag_str = item.text
              tag_id = Tag.find_or_create_by(name: tag_str).id
              Tagging.create({tag_id: tag_id, company_id: company.id})
            end
          end
        end
      rescue
         next
      end
    end
    time_end = Time.new.to_i
    puts "#{url[-10..-1]}----------------end---------Time:#{time_end-time_start}s----------"
  end
 
end