class TvShow < ActiveRecord::Base
  belongs_to :user
  has_many :episodes

  validates :user, presence: true
  validates :name, presence: true
end
