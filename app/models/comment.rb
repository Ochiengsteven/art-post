class Comment < ApplicationRecord
  validates :text, presence: true
  belongs_to :user
  belongs_to :post

  after_create :update_post_comments_counter
  after_destroy :update_post_comments_counter

  private

  def update_post_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
