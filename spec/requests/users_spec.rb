require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { User.create(name: 'John', photo: 'https://example.com/john.jpg', bio: 'Lorem ipsum') }

  describe 'GET /users' do
    it 'returns a successful response' do
      get users_path
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get users_path
      expect(response.body).to include('All Users')
    end
  end

  describe 'GET /users/:id' do
    it 'returns a successful response' do
      get user_path(user)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get user_path(user)
      expect(response.body).to include('List of posts for a User')
    end
  end
end
