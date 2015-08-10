module ApplicationHelper

  def birt(rptdesign_name=nil)
    "<div class=\"birt\" data-rptdesign=\"#{rptdesign_name||params[:_report]}.rptdesign\"></div>".html_safe
  end
end