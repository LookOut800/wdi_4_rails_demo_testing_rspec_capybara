class CommentsController < ApplicationController
  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments
  end

  def new
    @article = Article.find(params[:article_id])
    @comment = Comment.new
  end

  def create
       @article = Article.find(params[:article_id])
       @comment = @article.comments.create(comment_params)

    if @comment.save
      flash[:success] = 'Comment successfully created.'
      redirect_to article_path(@article)
    else
      render :new
    end
  end

private
  def article_params
    params.require(:article).permit(:title, :body)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
