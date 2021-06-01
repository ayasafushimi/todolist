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

  def done
    @article = Article.find(params[:id])
    @article.update(done: true)

    redirect_to '/articles'
  end

  def search
    @q = Article.ransack(params[:q])
    @articles = @q.result.page(params[:page]).per(3)
  end

  private
    def article_params
      params.require(:article).permit(:text, :datetime)
    end


end
