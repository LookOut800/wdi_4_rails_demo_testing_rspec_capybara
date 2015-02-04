require 'rails_helper'

RSpec.describe CommentsController do
 before(:all) do
    @article = Article.create!(title: 'One Stupid Trick', body: "You won't believe what they did next...")
    @comments = @article.comments
  end
  describe 'GET index' do
    it 'has 200 status code' do
      get :index, article_id: @article.id
      expect(response.status).to eq 200
    end

    it 'renders the index template' do
      get :index, article_id: @article.id
      expect(response).to render_template('index')
    end

    it 'assigns @comments' do
      get :index, article_id: @article.id
      expect(assigns(:comments)).to eq @comments
    end
  end


end
