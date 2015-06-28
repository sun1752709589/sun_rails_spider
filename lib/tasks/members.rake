#encoding: utf-8
namespace :members do
  task :catch do
    Rake::Task[:environment].invoke
    puts "--------------catch members start-------------------"
    agent = Mechanize.new
    (105..150).each do |i|
      url = "http://www.youyuan.com/find/beijing/mm0-0/advance-0-0-0-0-0-0-0/p#{i}/"
      catch_member(agent,url)
      sleep 0.001
    end
    puts "-----------catch members end----------------"
  end
  
  def catch_member(agent,url)
    page = agent.get(url)
    html_doc = Nokogiri::HTML(page.body)
    arr = html_doc.xpath("//ul[@class='mian search_list']/li")
    arr.each do |li|
      member = Member.new({unique_id: rand(9999999999999),platform: -1})
      member_info = MemberInfo.new
      detail_url = "http://www.youyuan.com" + li.xpath(".//a[@target='_blank']").first.attributes['href'].value
      detail_page = agent.get(detail_url)
      div_person_doc = Nokogiri::HTML(detail_page.body)
      avatar = div_person_doc.css("dl[class='personal_cen'] dt img").first['src']
      nickname = div_person_doc.css("div[class='main'] strong").first.text
      info_arr = div_person_doc.css("p[class='local']").first.text.split(' ').map{|item| item.strip}
      # ["北京市区", "40岁", "164cm", "2000-5000元", "已购房"]
      region = Region.where(name: info_arr[0][0..1]).first
      region = Region.find(1) if region.nil?
      member_info.birthday = info_arr[1].to_i.years.ago.to_s
      member_info.height = info_arr[2].to_i
      member_info.nickname = nickname
      member_avatar = MemberAvatar.create({status: 0,avatar: avatar})
      member.member_info = member_info
      member.member_avatar = member_avatar
      member.save
    end
    puts "#{url[-8..-2]}----------------end-------------------"
  end
end