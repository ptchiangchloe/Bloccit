class Comment < ActiveRecord::Base
  has_many :commentings
  has_many :topics, through: :commentings, source: :commentable, source_type: :Topic
  has_many :posts, through: :commentings, source: :commentable, source_type: :Post

  def self.update_comments(comment_string)
    return Comment.none if comment_string.blank?

    comment_string.split(",").map do |comment|
      Comment.find_or_create_by(body: comment.strip)
    end
  end
end
