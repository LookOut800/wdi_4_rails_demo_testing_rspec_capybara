class CommentsController < ApplicationController
  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments
  end

  def new
    @article = Article.find(params[:article_id])
    @comment = Comment.new
  end

private
  def article_params
    params.require(:article).permit(:title, :body)
  end
end
