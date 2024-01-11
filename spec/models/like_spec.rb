require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John', photo: 'https://example.com/john.jpg', bio: 'Lorem ipsum') }
  let(:post) { Post.create(author: user, title: 'Test Post', text: 'This is a test post') }
  subject { Like.new(user: user, post: post) }

  it 'updates post likes_counter when a like is added' do
    initial_likes_counter = 0
    expect(subject.post.likes_counter).to eq(initial_likes_counter)
    subject.save
    expect(subject.post.reload.likes_counter).to eq(initial_likes_counter + 1)
  end
end
