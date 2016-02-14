class Episode < ActiveRecord::Base
  belongs_to :tv_show
  belongs_to :user

  validates :tv_show, presence: true
  validates :user, presence: true
end
