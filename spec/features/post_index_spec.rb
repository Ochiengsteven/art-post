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

    it 'shows the first 5 recent comments on a post' do
      post_with_comments = Post.create(author: user, title: 'Post with comments', text: 'This post has comments')
      7.times { |i| post_with_comments.comments.create(text: "Comment #{i + 1}") }

      visit user_posts_path(user)

      within('.post-container', text: post_with_comments.title) do
        post_with_comments.recent_comments(5).each do |comment|
          expect(page).to have_content(comment.text)
        end
      end
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
    it 'shows a section for pagination ' do
      expect(page).to have_button('Pagination')
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
