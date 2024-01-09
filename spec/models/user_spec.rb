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
end
