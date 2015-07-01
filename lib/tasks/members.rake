#encoding: utf-8
namespace :catch do
  task :catch_articles do
    Rake::Task[:environment].invoke
    puts "--------------catch articles start-------------------"
    time_start = Time.new.to_i
    agent = Mechanize.new
    code_entity = HTMLEntities.new
    (1..100).each do |i|
      aaa = rand(2)
      if 0 == aaa && i < 90
        url = "https://ruby-china.org/topics/popular?page=#{i}"
      else
        url = "https://ruby-china.org/topics?page=#{i}"
      end
      catch_ruby_china_article(agent,url,code_entity)
      sleep 1
    end
    time_end = Time.new.to_i
    puts "-----------catch members end----------Time:#{time_end-time_start}s------"
  end
  def catch_ruby_china_article(agent,url,code_entity)
    time_start = Time.new.to_i
    page = agent.get(url)
    html_doc = Nokogiri::HTML(page.body)
    arr = html_doc.xpath("//div[@class='title media-heading']")
    arr.each do |li|
      begin
        article = Article.new
        article.base_url = "https://ruby-china.org" + li.xpath(".//a").first.attributes['href'].value
        detail_page = agent.get(article.base_url)
        doc = Nokogiri::HTML(detail_page.body)
        article.name = doc.css("div[class='media-body'] h1").first.text
        article.content = code_entity.encode(doc.css("div[class='panel-body markdown']").first.to_html)
        #article.content = article.name
        article.author = "https://ruby-china.org" + doc.css("div[class='avatar media-right'] a").first['href']
        article.read_num = doc.css("div[class='info']").first.text.strip.split(' ')[-2].to_i
        article.article_type = doc.css("div[class='info'] a").first.text.strip
        article.save
      rescue
         next
      end
    end
    time_end = Time.new.to_i
    puts "#{url[-10..-1]}----------------end---------Time:#{time_end-time_start}s----------"
  end
  task :catch_members do
    Rake::Task[:environment].invoke
    puts "--------------catch members start-------------------"
    time_start = Time.new.to_i
    agent = Mechanize.new
    # beijing:1000
    # tianjin:100
    (861..1000).each do |i|
      url = "http://www.youyuan.com/find/tianjin/mm0-0/advance-0-0-0-0-0-0-0/p#{i}/"
      catch_member(agent,url)
      sleep 0.1
    end
    time_end = Time.new.to_i
    puts "-----------catch members end----------Time:#{time_end-time_start}s------"
  end
  
  def catch_member(agent,url)
    time_start = Time.new.to_i
    page = agent.get(url)
    html_doc = Nokogiri::HTML(page.body)
    arr = html_doc.xpath("//ul[@class='mian search_list']/li")
    arr.each do |li|
      begin
        member = Member.new({unique_id: rand(9999999999999),platform: -1})
        member_info = MemberInfo.new
        detail_url = "http://www.youyuan.com" + li.xpath(".//a[@target='_blank']").first.attributes['href'].value
        detail_page = agent.get(detail_url)
        div_person_doc = Nokogiri::HTML(detail_page.body)
        avatar_img = div_person_doc.css("dl[class='personal_cen'] dt img").first
        avatar = avatar_img['src'] if avatar_img
        nickname_strong = div_person_doc.css("div[class='main'] strong").first
        nickname = nickname_strong.text if nickname_strong
        info_arr = div_person_doc.css("p[class='local']").first.text.split(' ').map{|item| item.strip}
        # ["北京市区", "40岁", "164cm", "2000-5000元", "已购房"]
        region = Region.where(name: info_arr[0][0..1]).first
        region = Region.find(1) if region.nil?
        member_info.birthday = info_arr[1].to_i.years.ago.to_s
        member_info.height = info_arr[2].to_i
        member_info.nickname = nickname
        member_info.sex = 1
        member_avatar = MemberAvatar.new({status: 0,avatar: avatar})
        member.member_info = member_info
        member.member_avatar = member_avatar
        member.save
      rescue
         next
      end
    end
    time_end = Time.new.to_i
    puts "#{url[-8..-2]}----------------end---------Time:#{time_end-time_start}s----------"
  end
end