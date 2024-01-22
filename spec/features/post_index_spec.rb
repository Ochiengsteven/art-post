# post_index_spec.rb
require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  let(:user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let!(:post) { Post.create(author: user, title: 'Hello', text: 'This is my first post') }

  context 'index page' do
    before do
      visit user_posts_path(user)
    end

    it "shows user's username" do
      expect(page).to have_content(user.name)
    end

    it "shows user's profile picture" do
      expect(page).to have_selector("img[src='#{user.photo}']")
    end

    it 'shows the number of posts for each user' do
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end

    it "shows a post's title" do
      expect(page).to have_content(post.title)
    end

    it "shows some of the post's body." do
      expect(page).to have_content(post.text[0, 200])
    end
  end

  context 'index' do
    before do
      visit user_posts_path(user)
    end

    it 'shows how many comments a post has.' do
      expect(page).to have_content("Comments: #{post.comments_counter}")
    end

    it 'shows how many likes a post has.' do
      expect(page).to have_content("Likes: #{post.likes_counter}")
    end
  end

  context 'Click' do
    before do
      visit user_posts_path(user)
    end

    it "redirects me to that post's show page when I click on a post" do
      click_link post.title
      expect(page).to have_current_path(post_path(post))
    end
  end
end
