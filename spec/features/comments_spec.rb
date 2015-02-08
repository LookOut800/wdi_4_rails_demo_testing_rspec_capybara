require 'rails_helper'

RSpec.feature 'Managing Comments' do
  scenario 'List all comments for a given article' do
    article = Article.create!(title: 'One Stupid Trick', body: "You won't believe what they did next...")
    Comment.create!(body: 'One stupid comment', article: article )
    Comment.create!(body: 'One stupid comment', article: article )
    Comment.create!(body: 'One stupid comment', article: article )

  visit "/articles/#{article.id}/comments"

  expect(page).to have_content 'Comments'
  expect(page).to have_selector 'p', count: 3
  end

  scenario 'Create a Comment' do
    article = Article.create!(title: 'One Stupid Trick', body: "You won't believe what they did next...")
    visit "/articles/#{article.id}/comments/new"

    fill_in 'Body', with: 'One stupid comment'
    click_on 'Create Comment'

    expect(page).to have_content(/success/i)
  end

  scenario 'Update a comment' do
    article = Article.create!(title: 'One Stupid Trick', body: "You won't believe what they did next...")

    visit "articles/#{article.id}/comment/edit"

    fill_in 'Body', with: 'Much disbelief. Updated comment.'
    click_on 'Update Comment'

    expect(page).to have_content(/success/i)
    expect(page.find('h1')).to have_content 'A Different Trick'
    expect(page).to have_content 'Much disbelief. Updated comment.'
  end
end

