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
      expect(assigns(:comments)).to eq  @comments
    end
  end

  describe 'GET new' do
    it 'has 200 status code' do
      get :new, article_id: @article.id
      expect(response.status).to eq 200
    end

    it 'renders the new template' do
      get :new, article_id: @article.id
      expect(response).to render_template('new')
    end

    it 'assigns @comments' do
      get :new, article_id: @article.id
      expect(assigns(:comment)).to be_a_new Comment
    end
  end

    describe 'POST create' do
    context 'with valid attributes' do
      it 'saves a new comment' do
        expect {
          post :create, comment: valid_attributes
        }.to change(Comment, :count).by 1
      end

      it 'assigns @comment' do
        post :create, comment: valid_attributes
        expect(assigns(:comment)).to be_an Article
        expect(assigns(:comment)).to be_persisted
      end

      it 'redirects to the created comment' do
        post :create, comment: valid_attributes
        expect(response).to redirect_to(Article.last)
      end
    end

    context 'with invalid attributes' do
      it 'assigns @comment, but does not save a new comment' do
        post :create, comment: invalid_attributes
        expect(assigns(:comment)).to be_a_new Article
      end

      it 're-renders the new template' do
        post :create, article: invalid_attributes
        expect(response).to render_template 'new'
      end
    end
  end


end
