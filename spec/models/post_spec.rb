require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:first_user) { User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Graphitti artist.') }
  let(:second_user) { User.create(name: 'Steve', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Artist contemporary.') }
  let(:first_post) { Post.create(author: first_user, title: 'Hello', text: 'This is my first post') }
  subject { Post.new(author: first_user, title: 'Hello', text: 'This is my first post') }

  it 'updates comments_counter when a comment is added' do
    initial_comments_counter = 0
    expect(subject.comments_counter).to eq(initial_comments_counter)
    subject.save
    subject.comments.create(post: first_post, user: second_user, text: 'Hi Tom!')
    expect(subject.reload.comments_counter).to eq(initial_comments_counter + 1)
  end

  describe '#update_author_posts_counter' do
    it 'updates the author posts counter' do
      user = User.create(name: 'Example User', photo: 'example.jpg', bio: 'Example bio')
      post = Post.create(author: user, title: 'Test Post', text: 'This is a test post')

      expect(post).to receive(:update_author_posts_counter).once

      post.update_author_posts_counter

      user.reload
      expect(user.posts_counter).to eq(1)
    end
  end

  it 'returns the most recent comments with the specified limit' do
    recent_comments = [
      Comment.create(post: first_post, user: first_user, text: 'Comment 1', created_at: Time.now - 1.hour),
      Comment.create(post: first_post, user: first_user, text: 'Comment 2', created_at: Time.now - 30.minutes),
      Comment.create(post: first_post, user: first_user, text: 'Comment 3', created_at: Time.now - 10.minutes)
    ]

    expected_attributes = recent_comments.map { |comment| comment.attributes.slice('text', 'created_at') }

    expect(first_post.recent_comments(3).order(created_at: :desc).pluck(:text,
                                                                        :created_at)).to match_array(expected_attributes.pluck(
                                                                                                       'text', 'created_at'
                                                                                                     ))
  end

  it 'should raise an error if comments_counter is negative' do
    subject.comments_counter = -1
    expect(subject).not_to be_valid
  end

  it 'should be valid when comments_counter is zero' do
    subject.comments_counter = 0
    expect(subject).to be_valid
  end

  it 'should be valid when comments_counter is positive' do
    subject.comments_counter = 5
    expect(subject).to be_valid
  end

  it 'is valid with a title' do
    expect(subject).to be_valid
  end

  it 'is invalid without a title' do
    subject.title = nil
    expect(subject).not_to be_valid
  end

  it 'is valid with a title of maximum length (250 characters)' do
    title = 'S' * 250
    subject.title = title
    expect(subject).to be_valid
  end

  it 'is invalid with a title longer than 250 characters' do
    title = 'S' * 251
    subject.title = title
    expect(subject).not_to be_valid
  end

  it 'updates likes_counter when a like is added' do
    initial_likes_counter = 0
    expect(subject.likes_counter).to eq(initial_likes_counter)
    subject.save
    subject.likes.create(post: first_post, user: second_user)
    expect(subject.reload.likes_counter).to eq(initial_likes_counter + 1)
  end

  it 'should raise an error if likes_counter is negative' do
    subject.likes_counter = -1
    expect(subject).not_to be_valid
  end

  it 'should be valid when likes_counter is zero' do
    subject.likes_counter = 0
    expect(subject).to be_valid
  end

  it 'should be valid when likes_counter is positive' do
    subject.likes_counter = 5
    expect(subject).to be_valid
  end
end
