require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }

  before { subject.save }

  it 'updates posts_counter when a post is added' do
    initial_posts_counter = 0
    expect(subject.posts_counter).to eq(initial_posts_counter)

    subject.posts.create(title: 'test', text: 'test')

    expect(subject.reload.posts_counter).to eq(initial_posts_counter + 1)
  end

  it 'should raise an error if posts_counter is negative' do
    subject.posts_counter = -1
    expect(subject).not_to be_valid
  end

  it 'should be valid when posts_counter is zero' do
    subject.posts_counter = 0
    expect(subject).to be_valid
  end

  it 'should be valid when posts_counter is positive' do
    subject.posts_counter = 5
    expect(subject).to be_valid
  end

  describe '#recent_posts' do
    it 'returns the most recent posts with the specified limit' do
      post1 = subject.posts.create(title: 'Post 1', text: 'This is post 1')
      post2 = subject.posts.create(title: 'Post 2', text: 'This is post 2')
      post3 = subject.posts.create(title: 'Post 3', text: 'This is post 3')

      recent_posts = subject.recent_posts(2)

      expect(recent_posts).to eq([post3, post2])
      post1
    end

    it 'returns all recent posts if the limit is greater than the total number of posts' do
      post1 = subject.posts.create(title: 'Post 1', text: 'This is post 1')
      post2 = subject.posts.create(title: 'Post 2', text: 'This is post 2')
      post3 = subject.posts.create(title: 'Post 3', text: 'This is post 3')

      recent_posts = subject.recent_posts(5)

      expect(recent_posts).to eq([post3, post2, post1])
    end
  end
end
