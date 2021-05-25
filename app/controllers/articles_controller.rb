class ArticlesController < ApplicationController

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to '/articles'
    else
      render :new
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to '/articles'
  end

  private
    def article_params
      params.require(:article).permit(:text, :date, :time)
    end

end
