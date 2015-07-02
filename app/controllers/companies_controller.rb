class CompaniesController < ApplicationController
  def index
    @companies = Company.all
    @companies = @companies.page(params[:page]).per(params[:per])
  end
  def show
    @company = Company.find(params[:id])
    code_entity = HTMLEntities.new
    @content = code_entity.decode(@company.detail_introduce)
  end
end
