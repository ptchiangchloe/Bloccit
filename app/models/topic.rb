class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings

  scope :visible_to, -> publicly_viewable
  scope :publicly_viewable, -> (user) { user ? all : where(public: true)}
  scope :private_viewable, -> (user) { user ? user == admin || user == current_user : where(public: false)}
end
