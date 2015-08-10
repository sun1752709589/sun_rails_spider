require 'birt'
module Birt
  class ApiController < ActionController::Base
    protect_from_forgery with: :exception

    def index

      # rpt_design_path = params[:_report] || '003.rptdesign'
      rpt_design_path = '003.rptdesign'
      @rpt_design = Birt::Core::RptDesign.new("#{Rails.root}/reports/#{rpt_design_path}")

      #数据解析
      @rpt_design.parse_rpt
      @rpt_design.data_sets.values.each { |data_set| data_set.data_set_result }

    end
  end
end
