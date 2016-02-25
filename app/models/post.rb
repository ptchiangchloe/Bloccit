class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent:  :destroy

  default_scope { order('created_at DESC')}
  scope :order_by_title (topic, user)
  scope :ordered_by_reverse_created_at (topic, user)

  validates :title, length:{ minimum: 5 }, presence: true
  validates :body, length: {minimum: 20 }, presence: true
  validates :topic, presence:true
  validates :user, presence: true
end
