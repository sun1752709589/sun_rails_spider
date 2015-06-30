class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    @articles = @articles.page(params[:page]).per(params[:per])
  end
  def show
    @article = Article.find(params[:id])
    code_entity = HTMLEntities.new
    @content = code_entity.decode(@article.content)
  end
end
