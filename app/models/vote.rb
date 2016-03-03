class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  after_save :update_post
  after_create :create_vote
  validates :value, inclusion: { in: [-1,1], message: "%{value} is not a vaild vote." }, presence: true

  private

  def update_post
    post.update_rank
  end

  def create_vote
    post.create_vote
  end
end
