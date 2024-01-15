require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { User.create(name: 'John', photo: 'https://example.com/john.jpg', bio: 'Lorem ipsum') }
  let(:post) { Post.create(author: user, title: 'Test Post', text: 'This is a test post') }

  describe 'GET /users/:user_id/posts' do
    it 'returns a successful response' do
      get user_posts_path(user)
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get user_posts_path(user)
      expect(response.body).to include('All posts')
    end
  end

  describe 'GET /posts/:id' do
    it 'returns a successful response' do
      get post_path(post)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get post_path(post)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get post_path(post)
      expect(response.body).to include('Post Details')
    end
  end
end
