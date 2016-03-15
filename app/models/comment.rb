class Comment < ActiveRecord::Base
  has_many :commentings

  belongs_to :user
  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true

  def self.update_comments(comment_string)
    return Comment.none if comment_string.blank?

    comment_string.split(",").map do |comment|
      Comment.find_or_create_by(body: comment.strip)
    end
  end
end
