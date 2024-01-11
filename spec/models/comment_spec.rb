require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'John', photo: 'https://example.com/john.jpg', bio: 'Lorem ipsum') }
  let(:post) { Post.create(author: user, title: 'Test Post', text: 'This is a test post') }
  subject { Comment.new(user: user, post: post, text: 'A comment') }

  it 'updates post comments_counter when a comment is added' do
    initial_comments_counter = 0
    expect(subject.post.comments_counter).to eq(initial_comments_counter)
    subject.save
    expect(subject.post.reload.comments_counter).to eq(initial_comments_counter + 1)
  end
end
